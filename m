Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:54189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751715AbeBAVcB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Feb 2018 16:32:01 -0500
Subject: Re: failed exec() exit codes
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20180201145809.jjtadzla22wlw7rv@ws.net.home>
 <201802011701.19780.sweet_f_a@gmx.de>
 <20180201202249.65v5yicgejiewwvu@ws.net.home>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <3f789a8a-c1c3-a175-3c88-0e6d43758387@gmx.de>
Date: Thu, 1 Feb 2018 22:31:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180201202249.65v5yicgejiewwvu@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 02/01/18 21:22, Karel Zak wrote:
> On Thu, Feb 01, 2018 at 05:01:19PM +0100, Ruediger Meier wrote:
>> On Thursday 01 February 2018, Karel Zak wrote:
>>> Now we use on many places where commands executing another command:
>>>
>>>      execvp(argv[optind], argv + optind);
>>>      err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
>>>
>>> the problem is that EXIT_FAILURE is too generic and it does not
>>> provide any way how to detect failed exec()s.
>>
>> I think you did a bit too much. I assume that these exec codes are only
>> useful for the programs which get a "command" from the user's command
>> line. So that the user can expect the original exit code of his
>> wanted "command" if and only if it's not 126 or 127.
>>
>> So for taskset(1) these exit codes are good but maybe not needed for
>> swapon(1) or eject(1).
> 
> I know, but it seems no problem and it's good way to consolidate the
> error message and use the came code pattern.

But isn't it just an implementation detail that we exec umount(1)? If we
would replace that later by a library call, should we change the exit code
again?

>>> I have added a new macro errexec() to replace err(EXIT_FAILURE, ...).
>>>
>>> The new macro is compatible with coreutils way:
>>>
>>>      #define EX_EXEC_FAILED          126     /* Program located, but
>>> not usable. */ #define EX_EXEC_ENOENT          127     /* Could not
>>> find program to exec.  */
>>
>>
>> coreutils has even 2 more in "src/system.h" and each of these kind of
>> exec programs are *only* using these ones.
> 
> I have copied from this file ;-)
> 
>>
>> /* Exit statuses for programs like 'env' that exec other programs.  */
>> enum
>> {
>>    EXIT_TIMEDOUT = 124, /* Time expired before child completed.  */
>>    EXIT_CANCELED = 125, /* Internal error prior to exec attempt.  */
>>    EXIT_CANNOT_INVOKE = 126, /* Program located, but not usable.  */
>>    EXIT_ENOENT = 127 /* Could not find program to exec.  */
>> };
>>
>> like
>> $ chroot   --helpdassdf; echo $?
>> chroot: unrecognized option '--helpdassdf'
>> Try 'chroot --help' for more information.
>> 125
>>
>> Other projects like bash only support 126 and 127, like we do now
> 
> yes, I guess it's good enough.

Probably you are right, but rock solid error handling would only be possible
if we do it like coreutils' timeout for example. See "bad case 2" below. If
"timeout inval" would return 1 then one might think that the pattern was not
in the input. ;)

# normal case
$ echo "xyz" | timeout 10 grep -q "bla" ; echo $?
1

# bad case 1
$ echo "bla" | timeout 10 xxxgrep -q "bla" ; echo $?
timeout: failed to run command ‘xxxgrep’: No such file or directory
127

# bad case 2
$ echo "bla" | timeout inval  xxxgrep -q "bla" ; echo $?
timeout: invalid time interval ‘inval’
Try 'timeout --help' for more information.
125

cu,
Rudi

