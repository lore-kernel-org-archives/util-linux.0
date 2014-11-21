Return-Path: lvml@5t9.de
Message-ID: <546F6C04.4060300@5t9.de>
Date: Fri, 21 Nov 2014 17:44:52 +0100
From: Lutz Vieweg <lvml@5t9.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: fstrim tries to discard data beyond the last sector of a device
References: <m3qnrg$5gc$1@ger.gmane.org> <m4f77a$ivg$1@ger.gmane.org> <20141118110329.GG6704@x2.net.home>
In-Reply-To: <20141118110329.GG6704@x2.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 11/18/2014 12:03 PM, Karel Zak wrote:
> what is your fstrim command line, it would be nice to see strace
> output to verify the ioctl return code.

I will run the test again and post the relevant strace output.

>> If email to this list is not a suitable form to report such issues,
>> please let me know where I can report this issue better.
>
> Maybe you can ask linux-fs mailing list. It really does not seem like
> fstrim command issue.

Ok, I'll direct my next post on this issue to linux-fsdevel@vger.kernel.org
(CC this mailing list, just in case...)

Thanks for the pointer!

Regards,

Lutz Vieweg
