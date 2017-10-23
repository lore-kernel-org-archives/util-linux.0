Return-Path: jeff.sadowski@gmail.com
MIME-Version: 1.0
In-Reply-To: <CAM9ceLgCuBD6JE+qWGF=wfPwnnU_Cn91P5Yg=1EKuAC5zPQygw@mail.gmail.com>
References: <CAM9ceLjMPtUHNxj-G2YL=5w+dE+EoD+6rYKE1uDCDn5k19z8gw@mail.gmail.com>
 <20171023105347.e6k3xwnwmhvgfzgw@ws.net.home> <CAM9ceLgCuBD6JE+qWGF=wfPwnnU_Cn91P5Yg=1EKuAC5zPQygw@mail.gmail.com>
From: Jeff Sadowski <jeff.sadowski@gmail.com>
Date: Mon, 23 Oct 2017 09:26:26 -0600
Message-ID: <CAM9ceLh9xA4P7FZ3+v5sZ267F0EoAvqk1CV91iZg2fcbSy5Jcw@mail.gmail.com>
Subject: Re: wall logging or run command each post?
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

Another reason was I was going to get the email addresses of everyone
having a process running on my machines and send them all emails of
the wall messages as well.
Doesn't shutdown typically send a wall message? It is messages like
these that I would like to get emails to all my users.

My machines are connected to Active Directory so I can use ldapsearch
to get their email addresses.

On Mon, Oct 23, 2017 at 9:14 AM, Jeff Sadowski <jeff.sadowski@gmail.com> wrote:
> One of the reasons I added this request:
>
> My default desktop is XFCE and it uses gnome-terminals. I don't get
> wall messages in gnome-terminals and I wanted a simple way to get wall
> messages to my screen I was thinking about using notify-send
>
> On Mon, Oct 23, 2017 at 4:53 AM, Karel Zak <kzak@redhat.com> wrote:
>> On Wed, Oct 18, 2017 at 02:06:25PM -0600, Jeff Sadowski wrote:
>>> I would like to know if this feature is built into wall or is there a
>>> good work around?
>>
>> wall is usually used by superuser. I guess if you can all "wall" than
>> you can also call for example logger to write to the system logs. I
>> don't see reason to merge functionally of these tools together.
>>
>>> I would like to configure wall to run a script after anything is posted to wall.
>>
>> Why? Maybe there is better way go get your goal.
>>
>>> I would also like to log all wall messages. I could easily do that
>>> with a script.
>>
>> yes, script(1) is the right way
>>
>>     Karel
>>
>>
>> --
>>  Karel Zak  <kzak@redhat.com>
>>  http://karelzak.blogspot.com
