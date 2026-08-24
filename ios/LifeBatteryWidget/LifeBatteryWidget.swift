import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> LifeBatteryEntry {
    LifeBatteryEntry(
      date: Date(), percentage: 100, remainingDays: 0, isPercentageMode: true, isUnlocked: true)
  }

  func getSnapshot(in context: Context, completion: @escaping (LifeBatteryEntry) -> Void) {
    let entry = createEntry(date: Date(), userData: loadUserData())
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
    let calendar = Calendar.current
    let now = Date()
    let startOfToday = calendar.startOfDay(for: now)
    let userData = loadUserData()

    var entries: [LifeBatteryEntry] = []
    for dayOffset in 0..<7 {
      guard let entryDate = calendar.date(byAdding: .day, value: dayOffset, to: startOfToday) else {
        continue
      }
      entries.append(createEntry(date: entryDate, userData: userData))
    }

    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }

  private func loadUserData() -> (birthDate: Date, idealAge: Int, isPercentageMode: Bool)? {
    let defaults = UserDefaults(suiteName: "group.com.rururu.lifebt")
    guard let birthDateString = defaults?.string(forKey: "birthDate"),
      let birthDate = parseISO8601Date(birthDateString),
      let idealAge = defaults?.object(forKey: "idealAge") as? Int,
      idealAge > 0
    else { return nil }
    let isPercentageMode = (defaults?.object(forKey: "isPercentageMode") as? Bool) ?? true
    return (birthDate, idealAge, isPercentageMode)
  }

  // Written by the app when the premium entitlement changes. Defaults to
  // locked so a database error or missing sync can never unlock the widget.
  private func loadIsUnlocked() -> Bool {
    let defaults = UserDefaults(suiteName: "group.com.rururu.lifebt")
    return (defaults?.object(forKey: "isWidgetUnlocked") as? Bool) ?? false
  }

  private func createEntry(date: Date, userData: (birthDate: Date, idealAge: Int, isPercentageMode: Bool)?) -> LifeBatteryEntry {
    let isUnlocked = loadIsUnlocked()
    guard let userData else {
      return LifeBatteryEntry(
        date: date, percentage: 100, remainingDays: 0, isPercentageMode: true,
        isUnlocked: isUnlocked)
    }

    let percentage = remainingLifePercentage(
      birthDate: userData.birthDate,
      idealAge: userData.idealAge,
      now: date
    )
    let remainingDays = remainingLifeDays(
      birthDate: userData.birthDate,
      idealAge: userData.idealAge,
      now: date
    )
    return LifeBatteryEntry(
      date: date,
      percentage: percentage,
      remainingDays: remainingDays,
      isPercentageMode: userData.isPercentageMode,
      isUnlocked: isUnlocked
    )
  }
}

struct LifeBatteryEntry: TimelineEntry {
  let date: Date
  let percentage: Int
  let remainingDays: Int
  let isPercentageMode: Bool
  let isUnlocked: Bool
}

private func parseISO8601Date(_ string: String) -> Date? {
  let truncated = string.components(separatedBy: ".").first ?? string

  let formatter = ISO8601DateFormatter()
  formatter.timeZone = TimeZone.current
  formatter.formatOptions = [.withFullDate, .withTime, .withColonSeparatorInTime]
  return formatter.date(from: truncated)
}

private func computeDeathDate(
  birthDate: Date,
  idealAge: Int,
  calendar: Calendar
) -> Date {
  let birthComponents = calendar.dateComponents([.year, .month, .day], from: birthDate)
  var deathComponents = DateComponents()
  deathComponents.year = (birthComponents.year ?? 0) + idealAge
  deathComponents.month = birthComponents.month
  deathComponents.day = birthComponents.day
  return calendar.date(from: deathComponents) ?? birthDate
}

private func remainingLifePercentage(
  birthDate: Date,
  idealAge: Int,
  now: Date
) -> Int {
  let calendar = Calendar.current

  let birthOnly = calendar.startOfDay(for: birthDate)
  let nowOnly = calendar.startOfDay(for: now)
  let deathDate = computeDeathDate(
    birthDate: birthDate,
    idealAge: idealAge,
    calendar: calendar
  )
  let deathOnly = calendar.startOfDay(for: deathDate)

  if nowOnly < birthOnly || nowOnly >= deathOnly {
    return 0
  }

  let totalDays = calendar.dateComponents([.day], from: birthOnly, to: deathOnly).day ?? 0
  let remainingDays = calendar.dateComponents([.day], from: nowOnly, to: deathOnly).day ?? 0

  if totalDays <= 0 {
    return 0
  }

  return Int(ceil(Double(remainingDays) / Double(totalDays) * 100))
}

private func remainingLifeDays(
  birthDate: Date,
  idealAge: Int,
  now: Date
) -> Int {
  let calendar = Calendar.current

  let nowOnly = calendar.startOfDay(for: now)
  let deathDate = computeDeathDate(
    birthDate: birthDate,
    idealAge: idealAge,
    calendar: calendar
  )
  let deathOnly = calendar.startOfDay(for: deathDate)

  if nowOnly >= deathOnly {
    return 0
  }

  return calendar.dateComponents([.day], from: nowOnly, to: deathOnly).day ?? 0
}

func batteryColor(for percentage: Int) -> Color {
  if percentage > 50 {
    return Color(red: 16 / 255, green: 185 / 255, blue: 129 / 255)
  }
  if percentage >= 20 {
    return Color(red: 251 / 255, green: 191 / 255, blue: 36 / 255)
  }
  return Color(red: 244 / 255, green: 63 / 255, blue: 94 / 255)
}

struct LockedWidgetView: View {
  var body: some View {
    VStack(spacing: 8) {
      Image(systemName: "lock.fill")
        .font(.system(size: 24))
        .foregroundColor(.secondary)

      Text(String(localized: "widget.lockedTitle"))
        .font(.system(size: 12, weight: .bold))
        .foregroundColor(.primary)

      Text(String(localized: "widget.lockedDescription"))
        .font(.system(size: 10))
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
    }
    .padding(.horizontal, 4)
  }
}

struct LifeBatteryWidgetEntryView: View {
  var entry: Provider.Entry

  var body: some View {
    if entry.isUnlocked {
      unlockedBody
    } else {
      LockedWidgetView()
    }
  }

  private var unlockedBody: some View {
    VStack(spacing: 8) {
      Text(String(localized: "widget.titleLabel"))
        .font(.system(size: 12, weight: .bold))
        .textCase(.uppercase)
        .foregroundColor(.primary)

      HStack(spacing: 4) {
        ZStack {
          // Frame
          RoundedRectangle(cornerRadius: 16)
            .stroke(Color.primary, lineWidth: 4)

          // Filled bar (masked to percentage width)
          RoundedRectangle(cornerRadius: 12)
            .fill(batteryColor(for: entry.percentage))
            .padding(6)
            .mask(alignment: .leading) {
              GeometryReader { geo in
                let pct = CGFloat(max(min(entry.percentage, 100), 0))
                Rectangle()
                  .frame(width: geo.size.width * pct / 100)
              }
            }

          // Display text (percentage or remaining days)
          Text(verbatim: entry.isPercentageMode
            ? "\(entry.percentage)%"
            : "\(entry.remainingDays)\(String(localized: "widget.dayUnit"))")
            .font(.system(size: 26, weight: .bold, design: .rounded))
            .foregroundColor(.primary)
        }
        .frame(height: 56)

        // Battery knob
        UnevenRoundedRectangle(
          bottomTrailingRadius: 10,
          topTrailingRadius: 10
        )
        .fill(Color.primary)
        .frame(width: 10, height: 20)
      }
    }
    .padding(.horizontal, 4)
  }
}

struct LifeBatteryWidget: Widget {
  let kind: String = "LifeBatteryWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      if #available(iOS 17.0, *) {
        LifeBatteryWidgetEntryView(entry: entry)
          .containerBackground(.fill.tertiary, for: .widget)
      } else {
        LifeBatteryWidgetEntryView(entry: entry)
          .padding()
          .background()
      }
    }
    .configurationDisplayName(String(localized: "widget.displayName"))
    .description(String(localized: "widget.description"))
    .supportedFamilies([.systemSmall])
  }
}

#Preview(as: .systemSmall) {
  LifeBatteryWidget()
} timeline: {
  LifeBatteryEntry(
    date: .now, percentage: 100, remainingDays: 30000, isPercentageMode: true, isUnlocked: true)
  LifeBatteryEntry(
    date: .now, percentage: 65, remainingDays: 19500, isPercentageMode: true, isUnlocked: true)
  LifeBatteryEntry(
    date: .now, percentage: 35, remainingDays: 10500, isPercentageMode: false, isUnlocked: true)
  LifeBatteryEntry(
    date: .now, percentage: 10, remainingDays: 3000, isPercentageMode: false, isUnlocked: true)
  LifeBatteryEntry(
    date: .now, percentage: 0, remainingDays: 0, isPercentageMode: true, isUnlocked: true)
  LifeBatteryEntry(
    date: .now, percentage: 100, remainingDays: 30000, isPercentageMode: true, isUnlocked: false)
}
