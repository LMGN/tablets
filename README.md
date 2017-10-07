# LMGNTablets

To import into a scriptbuilder (show tablets to everyone)

```
http/http://www.thelmgn.com/tabs?username=YOUR_USERNAME
```

To import into a scriptbuilder (show tablets to only you)

```
httpl/http://www.thelmgn.com/tabs?username=YOUR_USERNAME
```

To import into a normal game place this into a script **not a localscript**.
```lua
loadstring(game:GetService("HttpService"):GetAsync("http://www.thelmgn.com/tabs?username=YOUR_USERNAME"))
script:Destroy()
```
