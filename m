Return-Path: jeff.sadowski@gmail.com
MIME-Version: 1.0
In-Reply-To: <CAM9ceLhURzEtMnpr21VwqUR1HG31J5hoRRWWbw0bZu1fQFLYmA@mail.gmail.com>
References: <CAM9ceLjMPtUHNxj-G2YL=5w+dE+EoD+6rYKE1uDCDn5k19z8gw@mail.gmail.com>
 <20171023105347.e6k3xwnwmhvgfzgw@ws.net.home> <CAM9ceLhURzEtMnpr21VwqUR1HG31J5hoRRWWbw0bZu1fQFLYmA@mail.gmail.com>
From: Jeff Sadowski <jeff.sadowski@gmail.com>
Date: Mon, 23 Oct 2017 16:20:19 -0600
Message-ID: <CAM9ceLiRqGy45GcpO6ai5dA7n8MmMt+ZB9FeAXrZf6sz-KvV2w@mail.gmail.com>
Subject: Re: wall logging or run command each post?
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 23, 2017 at 9:04 AM, Jeff Sadowski <jeff.sadowski@gmail.com> wrote:
> So my best bet is going to be to put
>
> alias wall=/script/wall.sh
>
> in my /etc/bash.bashrc
> and any other allowed shell rc's
> where my /script/wall.sh does the things I want.
> and change any scripts like my /etc/apcupsd/apccontrol
> and change its WALL=wall to WALL=/script/wall.sh
> as well.
>
> I'll just have to go searching through /etc/ for files containing wall
>
> This will get most things I care about but it might skip messages that
> some users may broadcast
> should adding the "#!/bin/bash" as the first line to shell scripts
> cause the script to use the alias?
>
This doesn't work so I'm stuck with having to find all scripts and
manually change them
and having to warn users about wall not having this capability

My current wall script looks like so

#!/bin/bash
# filename: /home/scripts/wall.sh
# purpose: to email myself wall messages and to log them
input="$@"
if [ "${input}" = "" ];then
 input=$(cat)
fi
logger -s "from ${BASH_SOURCE[0]} : $@" >/dev/null 2>&1
echo -e "${input}" | mutt -s "wall messages from $(hostname) at
$(date)" jeff.sadowski@gmail.com
echo -e "${input}" | /bin/wall


I'll work on getting it to other users's desktops as well but this all
seems like stuff that should be implemented in wall.
Another alternative is to wrap it and have a post upgrade script look
to see if wall is a symlink pointing to my script and if not move it
to /bin/real.wall and use /bin/real.wall in my scripts. I'm thinking
that would be the best.
Now to find the post upgrade scripts for centos, fedora and ubuntu.

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
