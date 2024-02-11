# NativeCalendar

## Installation Via SPM:
https://github.com/ahmedtalaatshaker/NativeCalendar/tree/main

## Usage:
1 - After installing the SPM, now you are ready to import the Calendar
<p align="center">
      <a href="https://drive.google.com/uc?export=view&id=1CHnxMiXbu9smkQDr0Fg8aN1q5S7viVyY"><img src="https://drive.google.com/uc?export=view&id=1CHnxMiXbu9smkQDr0Fg8aN1q5S7viVyY" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>

2 - Add UIView to Storyboard and set the class as the following
<p align="center">
      <a href="https://drive.google.com/uc?export=view&id=1A8-FTyBDMHfMQ29K-jit8TkZcmC2Biak"><img src="https://drive.google.com/uc?export=view&id=1A8-FTyBDMHfMQ29K-jit8TkZcmC2Biak" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>

3 - Add Constraints as the following
<p align="center">
      <a href="https://drive.google.com/uc?export=view&id=1054uxrZtAiviMhuFgjuvq5CJfuO_CkTJ"><img src="https://drive.google.com/uc?export=view&id=1054uxrZtAiviMhuFgjuvq5CJfuO_CkTJ" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>

4 - Finally the Code inside the ViewController itself
  - Create an @IBOutlet for the view
 <p align="center">
      <a href="https://drive.google.com/uc?export=view&id=1JrYB08n47JtmPeT5IsHpEuVu89vPcEQD"><img src="https://drive.google.com/uc?export=view&id=1JrYB08n47JtmPeT5IsHpEuVu89vPcEQD" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>

  - Create a Calendar Variable and set it to current zone and set the the day hours as 12
 <p align="center">
      <a href="https://drive.google.com/uc?export=view&id=1ACNN1PDXeZwjdhLLPM16jrHIpW7QzNgF"><img src="https://drive.google.com/uc?export=view&id=1ACNN1PDXeZwjdhLLPM16jrHIpW7QzNgF" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>

  - Set start and end dates for the Calendar "'value' is to determine the range of available months"
      <p align="center">
      <a href="https://drive.google.com/uc?export=view&id=1OC27n9-HvnOhKX9uF9gockpRVyZyLQjX"><img src="https://drive.google.com/uc?export=view&id=1OC27n9-HvnOhKX9uF9gockpRVyZyLQjX" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>

  - Ability to add Off-Days to be disabled from selection
    you can pass them as List of Dates directly or if you have them as List of Strings you can use on already implemented function just like the following
          <p align="center">
      <a href="https://drive.google.com/uc?export=view&id=1Uf-ILxOlUCWQ7uMtJBp-wqwG6BNE5BlX"><img src="https://drive.google.com/uc?export=view&id=1Uf-ILxOlUCWQ7uMtJBp-wqwG6BNE5BlX" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>

  - Ability to add Events to be displayed on the calendar as Red Dot.
    it will be the same as Off-Days but with extra variable which will contain the events itself,
    Called "CalendarData<Codable>" it will take a date and a list of codable events,
    any codable will work with it.
<p align="center">
      <a href="https://drive.google.com/uc?export=view&id=1OfuwDta5T5q-QtlVV1DampbHDmkFwasE"><img src="https://drive.google.com/uc?export=view&id=1OfuwDta5T5q-QtlVV1DampbHDmkFwasE" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>

<p align="center">
      <a href="https://drive.google.com/uc?export=view&id=13DFjYptcATw8wHQtJ8GjHnqQx0JIzwWT"><img src="https://drive.google.com/uc?export=view&id=13DFjYptcATw8wHQtJ8GjHnqQx0JIzwWT" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>

<p align="center">
      <a href="https://drive.google.com/uc?export=view&id=1twQcOOJR4N8dXUrRIzQJ-Hi2hBoOTLhb"><img src="https://drive.google.com/uc?export=view&id=1twQcOOJR4N8dXUrRIzQJ-Hi2hBoOTLhb" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>

  - Ability to Set Colors for the cell and it also has a default colors with a gradient background for the selected cells
<p align="center">
      <a href="https://drive.google.com/uc?export=view&id=19pJQKELu7C4Fy85D3F71r3GtwTwS6nMU"><img src="https://drive.google.com/uc?export=view&id=19pJQKELu7C4Fy85D3F71r3GtwTwS6nMU" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>

  - Finally set all the needed data to make it works
<p align="center">
      <a href="https://drive.google.com/uc?export=view&id=1IKnRUkN9-dkmyHIuX9dL4tPnzN6MxHAv"><img src="https://drive.google.com/uc?export=view&id=1IKnRUkN9-dkmyHIuX9dL4tPnzN6MxHAv" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>
<p align="center">
      <a href="https://drive.google.com/uc?export=view&id=1UWW4HSTevfR8sPuAHGC7X-tmzanW_rM3"><img src="https://drive.google.com/uc?export=view&id=1UWW4HSTevfR8sPuAHGC7X-tmzanW_rM3" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>

## Attachments:
<p> * Single Selection </p>
https://github.com/ahmedtalaatshaker/NativeCalendar/assets/16456219/f35eede9-8b59-469f-a7b6-1778ff01ecb4



