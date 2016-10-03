Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.magicbluesmoke.com ([82.195.144.49]:35180 "EHLO
        mail.magicbluesmoke.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbcJCP5c (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 3 Oct 2016 11:57:32 -0400
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
To: Karel Zak <kzak@redhat.com>, Stanislav Brabec <sbrabec@suse.cz>
References: <56D7409A.6050407@suse.cz>
 <20160307131358.kzu4qb5yu6u7fd4x@ws.net.home> <56DEF7A4.4090209@suse.cz>
 <20160929144015.7cij7pbva3etcqeo@ws.net.home>
 <20161003150410.asxbalgvvtc4fvhi@ws.net.home>
Cc: util-linux@vger.kernel.org,
        Federico Bento <up201407890@alunos.dcc.fc.up.pt>,
        Jiri Slaby <jslaby@suse.cz>
From: =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigBrady.com>
Message-ID: <945e3ac2-6da5-fc97-abca-595d949137fa@draigBrady.com>
Date: Mon, 3 Oct 2016 16:48:56 +0100
MIME-Version: 1.0
In-Reply-To: <20161003150410.asxbalgvvtc4fvhi@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/10/16 16:04, Karel Zak wrote:
> On Thu, Sep 29, 2016 at 04:40:15PM +0200, Karel Zak wrote:
>> On Tue, Mar 08, 2016 at 05:02:44PM +0100, Stanislav Brabec wrote:
>>> On Mar 7, 2016 at 14:13 Karel Zak wrote:
>>>> On Wed, Mar 02, 2016 at 08:35:54PM +0100, Stanislav Brabec wrote:
>>>>> There are some controversial things with the straightforward fix:
>>>>>
>>>>> setsid() prevents TIOCSTI attack described in the report (easy to
>>>>> reproduce), but it has side effects: It disconnects the task from job
>>>>> control. With setsid(), ^Z cannot be used for sending the application
>>>>> to background any more (easy to reproduce by calling setsid()
>>>>> unconditionally in the same place).
>>>>>
>>>>> su-common.c now calls setsid() only if new session is requested.
>>>>
>>>> Yes, it's pretty stupid situation.
>>>>
>>>> We have exactly specified setsid() use-cases and now TIOCSTI ioctl
>>>> forces us to modify the things (and maybe introduce regressions),
>>>> because the crazy ioctl is not possible to disable by any another
>>>> way...
>>>
>>> I would like to see a kernel support for selective disabling of TIOCSTI
>>> without side effects like setsid() has.
>>>
>>> setsid() fallback would be used for kernels that don't support it.
>>>
>>> I am not sure, how complicated would be adding of such feature to the
>>> kernel.
>>
>> I have applied patch based on libseccomp syscall filter:
>>
>>    https://github.com/karelzak/util-linux/commit/8e4925016875c6a4f2ab4f833ba66f0fc57396a2
>>
>> it works as expected, but IMHO it's workaround for our stupid kernel...
> 
>  Reverted. We need something else, something better.
> 
>  I'll try to play su/runuser pty container to fix this issue, it seems
>  sudo also support this use-case by use_pty flag.

I was wondering would the secomp solution be (more) appropriate for runcon(1),
since that's selinux specific?

cheers,
pádraig
