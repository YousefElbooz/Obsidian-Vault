---
date:
  "{ date:YYYY-MM-DD }":
type: daily
tags:
  - daily
  - university
  - programming
---
# 📅 {{date}}

## 🎯 Focus of the Day
- [ ] **Primary Goal:**
- [ ] **Secondary Goal:** 
# 👨‍👩‍👦 Family  
```dataview
TABLE 
    priority, 
    status, 
    link(contexts) AS Context
FROM "TaskNotes"
WHERE contains(contexts, "Family")
    AND status != "Completed"
    AND (striptime(due) = this.file.day OR striptime(scheduled) = this.file.day)
SORT 
    (striptime(due) = this.file.day) DESC,
    priority ASC
``````
## 🏛️ College (Ain Shams University)
- **Courses:**
```dataview
TABLE 
    priority, 
    status, 
    link(contexts) AS Context
FROM "TaskNotes"
WHERE contains(contexts, "College")
    AND status != "Completed"
    AND (striptime(due) = this.file.day OR striptime(scheduled) = this.file.day)
SORT 
    (striptime(due) = this.file.day) DESC,
    priority ASC
```
## 💻 Programming & Projects
- **Projects:**
```dataview
TABLE 
    priority, 
    status, 
    link(contexts) AS Context
FROM "TaskNotes"
WHERE contains(contexts, "Programming")
    AND status != "Completed"
    AND (striptime(due) = this.file.day OR striptime(scheduled) = this.file.day)
SORT 
    (striptime(due) = this.file.day) DESC,
    priority ASC
```
# 💤 Sleep Tracker
```dataviewjs
const gcal = this.app.plugins.plugins["google-calendar"]?.api;

if (!gcal) {
    dv.paragraph("⚠️ Google Calendar plugin not found.");
} else {
    const events = await gcal.getEvents({
        startDate: moment().subtract(7, 'days').startOf('day'),
        endDate: moment().endOf('day')
    });

    const sleepDataMap = {};
    events.forEach(e => {
        if (e.summary && e.summary.toLowerCase().includes("sleep")) {
            let start = moment(e.start.dateTime || e.start.date);
            let end = moment(e.end.dateTime || e.end.date);
            let duration = moment.duration(end.diff(start)).asHours();
            let dateKey = start.format("YYYY-MM-DD");
            
            sleepDataMap[dateKey] = (sleepDataMap[dateKey] || 0) + duration;
        }
    });

    const sortedDates = Object.keys(sleepDataMap).sort().reverse();

    if (sortedDates.length === 0) {
        dv.paragraph("🌙 No sleep events found.");
    } else {
        let totalHours = 0;
        let minGoal = 5;      // Your new normal
        let idealGoal = 8;    // Ideal target
        let oversleepLimit = 9.5; 
        let tableData = [];
        let oversleepDays = 0;

        sortedDates.forEach(date => {

            let duration = sleepDataMap[date];
            totalHours += duration;
            if (duration > oversleepLimit) oversleepDays++;

            // Progress bar logic
            let percent = Math.min((duration / idealGoal) * 100, 100);
            let barColor = "#4caf50"; // Green (Good)
            if (duration < minGoal) barColor = "#f44336"; // Red (Dangerously Low)
            else if (duration > oversleepLimit) barColor = "#2196f3"; // Blue (Oversleeping)
            else if (duration < 6.5) barColor = "#ffeb3b"; // Yellow (Low but okay)

            let progressBar = `<div style="width:100px; background:rgba(255,255,255,0.1); border-radius:5px; height:8px;"><div style="width:${percent}%; background:${barColor}; height:100%; border-radius:5px;"></div></div>`;

            // Calculate Difference from 5h Baseline
            let diff = duration - minGoal;
            let diffText = diff >= 0 ? `<span style="color:#4caf50">+${diff.toFixed(1)}</span>` : `<span style="color:#f44336">${diff.toFixed(1)}</span>`;

            tableData.push([
                moment(date).format("ddd, MMM DD"), 
                `**${duration.toFixed(2)}h**`, 
                diffText,
                dv.el("div", progressBar)
            ]);
        });

        const avg = (totalHours / sortedDates.length).toFixed(2);
        
        // 3. Render Dashboard Cards
        let cardContainer = dv.el("div", "", { attr: { style: "display: flex; gap: 10px; margin-bottom: 20px; flex-wrap: wrap;" }});
        const createCard = (label, value, color) => {
            let card = cardContainer.createEl("div", { attr: { style: `flex: 1; min-width: 100px; background: rgba(255,255,255,0.05); padding: 12px; border-radius: 8px; border-left: 4px solid ${color};` }});
            card.createEl("div", { text: label, attr: { style: "font-size: 0.75em; color: gray;" }});
            card.createEl("div", { text: value, attr: { style: "font-size: 1.2em; font-weight: bold;" }});
        }

        createCard("Avg Sleep", `${avg}h`, avg < minGoal ? "#f44336" : "#4caf50");
        createCard("Oversleep Days", oversleepDays, "#2196f3");
        createCard("Total Hours", totalHours.toFixed(1), "#9c27b0");

        // 4. Analysis Section
		dv.paragraph(`#### 🧠 Weekly Analysis`);
        if (avg > oversleepLimit) {
            dv.paragraph("> [!info] **Trend:** You are consistently oversleeping. This might lead to grogginess (sleep inertia). Try to cap sessions at 8.5 hours.");
        } else if (avg < minGoal) {
            dv.paragraph("> [!error] **Trend:** You are below your 5-hour baseline. This will likely impact your coding performance and focus.");
        } else {
            dv.paragraph("> [!success] **Trend:** Your sleep is within your defined healthy range.");
        }

        dv.table(["Date", "Duration", "vs. 5h Base", "Visual"], tableData);
    }
}
```

# Week Agenda
![[agenda-default.base]]