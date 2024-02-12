# Native Calendar

## Installation Via SPM:
https://github.com/ahmedtalaatshaker/NativeCalendar/tree/main

## Usage:
1 - After installing the SPM, now you are ready to import the Calendar
 <p align="center">
      <a href="https://drive.google.com/uc?export=view&id=1JrYB08n47JtmPeT5IsHpEuVu89vPcEQD"><img src="https://drive.google.com/uc?export=view&id=1JrYB08n47JtmPeT5IsHpEuVu89vPcEQD" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
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
      <a href="https://drive.google.com/uc?export=view&id=1CHnxMiXbu9smkQDr0Fg8aN1q5S7viVyY"><img src="https://drive.google.com/uc?export=view&id=1CHnxMiXbu9smkQDr0Fg8aN1q5S7viVyY" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
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
      <a href="https://drive.google.com/uc?export=view&id=1uz0sfnSx5fUCYUSMrO2EXhYucsHTSpfX"><img src="https://drive.google.com/uc?export=view&id=1uz0sfnSx5fUCYUSMrO2EXhYucsHTSpfX" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>

  - Finally set all the needed data to make it works
<p align="center">
      <a href="https://drive.google.com/uc?export=view&id=1r44QsJVfSDqpoLamwv2EtCYWtv5ubEUM"><img src="https://drive.google.com/uc?export=view&id=1r44QsJVfSDqpoLamwv2EtCYWtv5ubEUM" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>
<p align="center">
      <a href="https://drive.google.com/uc?export=view&id=1UWW4HSTevfR8sPuAHGC7X-tmzanW_rM3"><img src="https://drive.google.com/uc?export=view&id=1UWW4HSTevfR8sPuAHGC7X-tmzanW_rM3" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />
</p>

## Attachments:
<table>
      <lr>
            <li>
                  <h3>Single Selection: </h3>
                  <img src="https://github.com/ahmedtalaatshaker/NativeCalendar/assets/16456219/6b752180-8566-42ef-bfd9-a7ed7878a0c3.gif" style="width: 300px; height: 450px" />
            </li>
            <li>
                  <h3>Multi Selection "Friday as start of week": </h3>
                  <img src="https://github.com/ahmedtalaatshaker/NativeCalendar/assets/16456219/f9fa4ede-3bc5-457b-8977-8ac66be68c93.gif" style="width: 250px; height: 450px" />
            </li>
      </lr>
      <lr>
            <li>
                 <h3>From - To Selection "Saturday as start of week":</h3>
                 <img src="https://github.com/ahmedtalaatshaker/NativeCalendar/assets/16456219/1c51a21c-60fd-46b7-b73e-e7cb06cd8128.gif" style="width: 250px; height: 450px" />
            </li>
            <li>
                  <h3>Square Cell:</h3>
                  <img src="https://github.com/ahmedtalaatshaker/NativeCalendar/assets/16456219/4c9e4269-9c42-4269-b580-4b95e07a148c.gif" style="width: 250px; height: 450px" />
            </li>
      </lr>
</table>

## Demo:
https://github.com/ahmedtalaatshaker/NativeCalendarExample
