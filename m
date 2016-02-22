Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] tests: add test for loop option in fstab
To: Karel Zak <kzak@redhat.com>
References: <56BCE4F4.6020409@suse.cz> <201602151242.10369.sweet_f_a@gmx.de>
 <20160216144918.iqmvz27qggxfnjng@ws.net.home> <56C75E7B.60407@suse.cz>
 <20160222101233.imyhujomel6ydin3@ws.net.home>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56CB3909.4080808@suse.cz>
Date: Mon, 22 Feb 2016 17:36:25 +0100
MIME-Version: 1.0
In-Reply-To: <20160222101233.imyhujomel6ydin3@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

On Feb 22, 2016 at 11:12 Karel Zak wrote:
> On Fri, Feb 19, 2016 at 07:27:07PM +0100, Stanislav Brabec wrote:
>> On Feb 16 2016 at 15:49 Karel Zak wrote:
>>> On Mon, Feb 15, 2016 at 12:42:10PM +0100, Ruediger Meier wrote:
>>>> On Thursday 11 February 2016, Stanislav Brabec wrote:
>>>>> Add a new fstab tests which check loop mount of the same source
>>>>> multiple times in multiple steps.
>>>>
>>>> This test still fails if /etc/mtab is a regular file.
>>>
>>> The problem should be fixed now. Thanks!
>>>
>> Well, not for btrfs. See the new testcase below (ready for inclusion to the
>> GIT).
>
> Do you mean when /etc/mtab is a regular file? For btrfs we need fs
> root and this information is nowhere in mtab (and maybe another
> information related to subvolumes which we have in mountinfo).

No, My new testcase fails on a system with mtab being a symlink:

# ls -al /etc/mtab
lrwxrwxrwx 1 root root 19 Jul  7  2015 /etc/mtab -> ../proc/self/mounts

Not tested with a file.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
