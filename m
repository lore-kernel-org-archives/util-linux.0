Return-Path: sbrabec@suse.cz
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
To: Karel Zak <kzak@redhat.com>
References: <56D7409A.6050407@suse.cz>
 <20160307131358.kzu4qb5yu6u7fd4x@ws.net.home>
Cc: util-linux@vger.kernel.org,
        Federico Bento <up201407890@alunos.dcc.fc.up.pt>,
        Jiri Slaby <jslaby@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56DEF7A4.4090209@suse.cz>
Date: Tue, 8 Mar 2016 17:02:44 +0100
MIME-Version: 1.0
In-Reply-To: <20160307131358.kzu4qb5yu6u7fd4x@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

On Mar 7, 2016 at 14:13 Karel Zak wrote:
> On Wed, Mar 02, 2016 at 08:35:54PM +0100, Stanislav Brabec wrote:
>> There are some controversial things with the straightforward fix:
>>
>> setsid() prevents TIOCSTI attack described in the report (easy to
>> reproduce), but it has side effects: It disconnects the task from job
>> control. With setsid(), ^Z cannot be used for sending the application
>> to background any more (easy to reproduce by calling setsid()
>> unconditionally in the same place).
>>
>> su-common.c now calls setsid() only if new session is requested.
>
> Yes, it's pretty stupid situation.
>
> We have exactly specified setsid() use-cases and now TIOCSTI ioctl
> forces us to modify the things (and maybe introduce regressions),
> because the crazy ioctl is not possible to disable by any another
> way...

I would like to see a kernel support for selective disabling of TIOCSTI
without side effects like setsid() has.

setsid() fallback would be used for kernels that don't support it.

I am not sure, how complicated would be adding of such feature to the
kernel.

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
