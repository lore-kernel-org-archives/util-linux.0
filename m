Return-Path: renyuneyun@gmail.com
Subject: Re: [PATCH] scriptreplay: determine if script --quiet was used to
 create typescript
To: kerolasa@gmail.com, Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
References: <20170414203948.12295-1-kerolasa@iki.fi>
 <20170418102305.pfzvyukxj5fb6wsx@ws.net.home>
 <CAG27Bk1iUXNAhc2Ene2h-9=RC4BLn0VK6q_JV_dJKe9Cc-iqsg@mail.gmail.com>
From: renyuneyun <renyuneyun@gmail.com>
Message-ID: <84ce33db-7ae8-59b8-4ff8-d404462cb7b8@gmail.com>
Date: Wed, 19 Apr 2017 22:57:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAG27Bk1iUXNAhc2Ene2h-9=RC4BLn0VK6q_JV_dJKe9Cc-iqsg@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------471130120059D6AA88AA28C8"
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------471130120059D6AA88AA28C8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On Fri, 14 Apr 2017 21:39:48 +0100, Sami Kerola wrote:
> Recent commit that removed header timestamp from typescript output when
> --quiet option is defined broke scriptreplay.  Trouble was that scriptreplay
> always skipped first line of the typescript.  But --quiet makes that line to
> be part of what must be printed by scriptreplay.
Whoops, it's the first time I use script so I wasn't aware that would be 
related to scriptreplay. Sorry for the unexpected influence ;)

Are there any special bytes or format to be used to determine that? For 
example, can we assume the first line after the header is always a 
command or empty line (meaning that nobody will try to mimic the header 
in his input)?

On Tue, 18 Apr 2017 12:23:05 +0200, Karel Zak wrote:
> Not sure about it. It seems like overkill...
>
> I have reverted Rui's change and fixed the man page.
>
> It seems better to keep things simple and stupid... it means keep
> typescript file completely independent on the --quit option (for the
> both, start and done messages).
As it comes to man page, what do you think of adding a note there to 
show why the start message isn't suppressed?

On Wed, 19 Apr 2017 19:11:57 +0100, Sami Kerola wrote:
> On 18 April 2017 at 11:23, Karel Zak <kzak@redhat.com> wrote:
>
>> Anyway, I don't like officially supported file formats without any
>> header. IMHO it would be really nice to add to the typescript:
>>
>>   ### script(1) typescript; Version: util-linux v2.30; Date: 2017-04-18 12:10:43+0200
>>
>> ... and maybe more information. The same for timing file.
> I agree. What comes to header data it should include header length
> in bytes. Something like
>
> ### script(1) typescript; Header Length: 104 Version: util-linux
> v2.30; Date: 2017-04-18 12:10:43+0200
>
> As long it's easy to know how long to jump rest of the format does
> not really matter. Right.
Forgive my witless, what's the point of introducing a length? Doesn't we 
already know the header takes (and only takes) the first line?


--------------471130120059D6AA88AA28C8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body smarttemplateinserted="true" text="#000000" bgcolor="#FFFFFF">
    <div id="smartTemplate4-quoteHeader">
      <div id="smartTemplate4-quoteHeader">On Fri, 14 Apr 2017 21:39:48
        +0100, Sami Kerola wrote:</div>
      <blockquote type="cite"
        cite="mid:20170414203948.12295-1-kerolasa@iki.fi">
        <pre wrap="">Recent commit that removed header timestamp from typescript output when
--quiet option is defined broke scriptreplay.  Trouble was that scriptreplay
always skipped first line of the typescript.  But --quiet makes that line to
be part of what must be printed by scriptreplay.</pre>
      </blockquote>
      Whoops, it's the first time I use script so I wasn't aware that
      would be related to scriptreplay. Sorry for the unexpected
      influence ;)<br>
      <br>
      Are there any special bytes or format to be used to determine
      that? For example, can we assume the first line after the header
      is always a command or empty line (meaning that nobody will try to
      mimic the header in his input)?<br>
      <br>
      On Tue, 18 Apr 2017 12:23:05 +0200, Karel Zak wrote:</div>
    <blockquote type="cite"
      cite="mid:20170418102305.pfzvyukxj5fb6wsx@ws.net.home">
      <pre wrap="">Not sure about it. It seems like overkill... 

I have reverted Rui's change and fixed the man page.

It seems better to keep things simple and stupid... it means keep
typescript file completely independent on the --quit option (for the
both, start and done messages).
</pre>
    </blockquote>
    As it comes to man page, what do you think of adding a note there to
    show why the start message isn't suppressed?<br>
    <br>
    On Wed, 19 Apr 2017 19:11:57 +0100, Sami Kerola wrote:
    <blockquote type="cite"
cite="mid:CAG27Bk1iUXNAhc2Ene2h-9=RC4BLn0VK6q_JV_dJKe9Cc-iqsg@mail.gmail.com">
      <pre wrap="">On 18 April 2017 at 11:23, Karel Zak <a class="moz-txt-link-rfc2396E" href="mailto:kzak@redhat.com">&lt;kzak@redhat.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="">Anyway, I don't like officially supported file formats without any
header. IMHO it would be really nice to add to the typescript:

 ### script(1) typescript; Version: util-linux v2.30; Date: 2017-04-18 12:10:43+0200

... and maybe more information. The same for timing file.
</pre>
      </blockquote>
      <pre wrap="">
I agree. What comes to header data it should include header length
in bytes. Something like

### script(1) typescript; Header Length: 104 Version: util-linux
v2.30; Date: 2017-04-18 12:10:43+0200

As long it's easy to know how long to jump rest of the format does
not really matter. Right.
</pre>
    </blockquote>
    Forgive my witless, what's the point of introducing a length?
    Doesn't we already know the header takes (and only takes) the first
    line?<br>
    <br>
  </body>
</html>

--------------471130120059D6AA88AA28C8--
