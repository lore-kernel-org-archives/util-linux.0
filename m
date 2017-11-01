Return-Path: prarit@redhat.com
Subject: Re: [PATCH] dmesg: Add force-prefix option
To: Karel Zak <kzak@redhat.com>
References: <20171031120131.5837-1-prarit@redhat.com>
 <20171101144703.adnh6nnft2c3f5qv@ws.net.home>
Cc: util-linux@vger.kernel.org, anderson@redhat.com
From: Prarit Bhargava <prarit@redhat.com>
Message-ID: <59dcdf01-43d1-517e-ac6b-d0b23147d6f5@redhat.com>
Date: Wed, 1 Nov 2017 12:52:29 -0400
MIME-Version: 1.0
In-Reply-To: <20171101144703.adnh6nnft2c3f5qv@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 11/01/2017 10:47 AM, Karel Zak wrote:
> On Tue, Oct 31, 2017 at 08:01:31AM -0400, Prarit Bhargava wrote:
>> The kernel outputs multi-line messages (kernel messages that contain
>> the end-of-line character '\n').  These message are currently displayed by
>> dmesg as
>>
>> [965199.028940] runnable tasks:
>>                            task   PID         tree-key  switches  prio
>> wait-time             sum-exec        sum-sleep
>>                 ----------------------------------------------------------------------------------------------------------
>>
>> The kernel timestamps each of these lines with [965199.028940] and the
>> dmesg utility should do the same.
>>
>> Add the 'force-prefix'/'-p' dmesg option to add decode & timestamp information
>> to each line of a multi-line message.
>>
>> Notes: The new print_record() algorithm stores the decode & timestamp
>> information in buffers.  If the force-prefix option is used, the message is
>> split into separate lines and each line is prefixed with the stored decode &
>> timestamp information.  The splitting of the message into separate lines is
>> done using strtok() which requires write access to the message buffer (ie, the
>> const message buffer is now copied into a writeable buffer).
>>
>> Successfully tested by me by looking at sysrq-t and sysrq-w output.
>> All known good /tests passed with these changes.
> 
> Merged with some changes:
> 
>      - use snprintf()
>      - cleanup \n usage (don't count line break to the
>        message text in the parsers  and always print \n after the text
>      - add the option to the man page
>      - use --force-prefix for kmsg only, old syslog(2) API splits messages itself
>      - strdup() the message text only on force-prefix
> 
> Please, test it again :-)
>

Done :) and IMO the tests pass.

Note that there are 3 tests/ that that fail before and after my patch.

I tested and old and new dmesg using alt-sysrq-w.

The kernel console displays

<snip>
[101640.296136]   .rt_throttled                  : 0
[101640.301374]   .rt_time                       : 0.000000
[101640.307288]   .rt_runtime                    : 950.000000
[101640.313396]
[101640.313396] runnable tasks:
[101640.313396]             task   PID         tree-key  switches  prio
wait-time             sum-exec        sum-sleep
[101640.313396]
----------------------------------------------------------------------------------------------------------
<snip>

and old dmesg shows

[101640.296136]   .rt_throttled                  : 0
[101640.301374]   .rt_time                       : 0.000000
[101640.307288]   .rt_runtime                    : 950.000000
[101640.313396]
runnable tasks:
            task   PID         tree-key  switches  prio     wait-time
 sum-exec        sum-sleep
----------------------------------------------------------------------------------------------------------

The new dmesg (no additional options) shows

[101640.296136]   .rt_throttled                  : 0
[101640.301374]   .rt_time                       : 0.000000
[101640.307288]   .rt_runtime                    : 950.000000
[101640.313396]
                runnable tasks:
                            task   PID         tree-key  switches  prio
wait-time             sum-exec        sum-sleep

----------------------------------------------------------------------------------------------------------

which provides backwards compatibility with the old dmesg behavior

The new dmesg with --force-prefix shows

[101640.296136]   .rt_throttled                  : 0
[101640.301374]   .rt_time                       : 0.000000
[101640.307288]   .rt_runtime                    : 950.000000
[101640.313396] runnable tasks:
[101640.313396]             task   PID         tree-key  switches  prio
wait-time             sum-exec        sum-sleep
[101640.313396]
----------------------------------------------------------------------------------------------------------

The new dmesg with --force-prefix -e shows

[  +0.005237]   .rt_throttled                  : 0
[  +0.005238]   .rt_time                       : 0.000000
[  +0.005914]   .rt_runtime                    : 950.000000
[  +0.006108] runnable tasks:
[  +0.000000]             task   PID         tree-key  switches  prio
wait-time             sum-exec        sum-sleep
[  +0.000000]
----------------------------------------------------------------------------------------------------------

The new dmesg with --force-prefix -x shows

kern  :warn  : [101640.301374]   .rt_time                       : 0.000000
kern  :warn  : [101640.307288]   .rt_runtime                    : 950.000000
kern  :warn  : [101640.313396] runnable tasks:
kern  :warn  : [101640.313396]             task   PID         tree-key  switches
 prio     wait-time             sum-exec        sum-sleep
kern  :warn  : [101640.313396]
----------------------------------------------------------------------------------------------------------

So I think it works! :)

P.
>     Karel
> 
