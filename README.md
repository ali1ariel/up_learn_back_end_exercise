# Up Learn Back End Exercise
<br/>

A program that, by the given url, returns all images assets and links contained on that HTML file.
<br/>
<br/>

## Requirements
```
  Elixir 1.6 or above
```
<br/>
<br/>

  ## Using
  After clone this repository, you just need to initiate this project o iex using   
 ``` 
    iex -S mix
 ```
 And you can use modifying the below entry on IEX terminal.
 ``` 
  UpLearnBackEndExercise.fetch("https://www.google.com")
 ```
 The return will looks like it:

 ``` 
    {:ok, [%Link{...}, ..., %Asset{...}, ...]}
 ```
 when the given url generates an error, will looks like it:

 ``` 
    {:error, code}
 ```
code is an HTML error code and you can check here: <https://kb.iu.edu/d/bfrc>
<br/>
<br/>

## Built With

* [Elixir](https://elixir-lang.org/) 