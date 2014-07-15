Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60060 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755215AbaGOMkp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 08:40:45 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6FCehP8014892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 15 Jul 2014 08:40:44 -0400
Message-ID: <53C52149.6010301@redhat.com>
Date: Tue, 15 Jul 2014 14:40:41 +0200
From: Stef Walter <stefw@redhat.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt and reprint /etc/issue if we receive
 SIGUSR1
References: <1404718284-4192-1-git-send-email-stefw@redhat.com> <20140715074717.GN30288@x2.net.home> <53C4DED8.2070706@redhat.com> <20140715091907.GQ30288@x2.net.home>
In-Reply-To: <20140715091907.GQ30288@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 15.07.2014 11:19, Karel Zak wrote:
> On Tue, Jul 15, 2014 at 09:57:12AM +0200, Stef Walter wrote:
>> On 15.07.2014 09:47, Karel Zak wrote:
>>>  Now when I think about it.. would be better to have this feature
>>>  optional? I think it's overkill to have it enabled on all machines. 
>>
>> Sure.
>>
>>>  The another story is the signal usage (and possible race with login(1) as 
>>>  discussed at https://bugzilla.redhat.com/show_bug.cgi?id=1110763). 
>>>  
>>>  What about  for example: 
>>>
>>>    agetty --reload-trigger <file>
>>
>> As I said in the above bugzilla bug, I don't mind doing this ... but in
>> my opinion unix signals are meant exactly for this use case, and are
>> used by many (most?) other linx processes as a reload trigger.
> 
>  Yes, it's pretty common classic solution, but I think that in this
>  case it is not too robust solution.
> 
>>>  and use inotify for the <file>. I guess this way also allows to avoid
>>>  the ioctl() tty voodoo and you can use select() for the inotify and
>>>  tty file descriptors.
>>
>> Unfortunately that's not how it works. When in canonical mode, the tty
>> file descriptor only becomes readable once a complete line has been
>> entered. I've verified that select() does not return until <enter> is
>> pressed.
> 
>  Ah.. good point, but with non-canonical mode it works as expected,
>  right? So, we can use fd with VMIN=1 and inotify fd for the select().

Yup.

>  Maybe the best would be to implement all within agetty, I mean add
>  a special command 
> 
>    agetty --reload [<tty>]
> 
>  to reload another already running agetty process(es). So rather than
>  "killall agetty" you have to use "agetty --reload".
>  
>  Then all the implementation will be a private thing and only the "--reload"
>  command line option will be a public API.

Okay. I'll work on this and keep you posted.

>  Note that we does not control code of all login(1) implementations
>  and we have --login-program <path> to start arbitrary random thing
>  from agetty, so our solution have to be generic rather than rely 
>  on any login(1) change.

Well you don't need to modify login(1) (or other --login-program's) at
all. SIG_IGN is kept across an exec.

Stef
