#import "viz/timetable.typ": timetable

#set page(margin: 0.5cm, height: auto)

#timetable(
  json("schedule.json"),
  //language: "it",
  //date: [this year],
  //show-header: false,
  //show-alternatives: false,
  //show-description: false,
  //color-theme: "Set1_9",
)
