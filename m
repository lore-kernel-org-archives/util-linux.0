Return-Path: kay.sievers@vrfy.org
MIME-Version: 1.0
In-Reply-To: <20110714115231.GF3486@nb.net.home>
References: <20110714115231.GF3486@nb.net.home>
From: Kay Sievers <kay.sievers@vrfy.org>
Date: Thu, 14 Jul 2011 15:45:30 +0200
Message-ID: <CAPXgP10m_1CFphdW=HTuma+u81iAJ0v3bfFK5eAMMkB8pXDqCg@mail.gmail.com>
Subject: Re: dmesg(1) changes
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 14, 2011 at 13:52, Karel Zak <kzak@redhat.com> wrote:
> I did some changes to dmesg(1) in last days:
>
> =C2=A0* \x<hex> encoding is used for non-printable chars and invalid
> =C2=A0 multibyte sequences
>
> =C2=A0* add --decode option to decode facility and level (priotity) numbe=
r to
> =C2=A0 human readable prefixes, for example:
>
> =C2=A0 =C2=A0$ dmesg --decode
> =C2=A0 =C2=A0kern =C2=A0:info =C2=A0: [53335.593617] ata1.00: configured =
for UDMA/100
> =C2=A0 =C2=A0kern =C2=A0:info =C2=A0: [53335.743185] PM: resume of device=
s complete after 2496.795 msecs
> =C2=A0 =C2=A0kern =C2=A0:debug : [53335.743593] PM: Finishing wakeup.
> =C2=A0 =C2=A0kern =C2=A0:warn =C2=A0: [53335.743595] Restarting tasks ...=
 done.
> =C2=A0 =C2=A0kern =C2=A0:info =C2=A0: [53335.790452] video LNXVIDEO:00: R=
estoring backlight state
>
> =C2=A0* add --facility=3D<LIST> option to filter out messages, for exampl=
e:
>
> =C2=A0 =C2=A0$ dmesg --facility=3Ddaemon,user
> =C2=A0 =C2=A0[ =C2=A0 =C2=A01.802065] dracut: dracut-009-11.fc15
> =C2=A0 =C2=A0[ =C2=A0 =C2=A01.811267] dracut: rd.luks=3D0: removing crypt=
oluks activation
> =C2=A0 =C2=A0[ =C2=A0 =C2=A01.813913] dracut: rd.lvm=3D0: removing LVM ac=
tivation
> =C2=A0 =C2=A0[ =C2=A0 =C2=A01.819348] udev[111]: starting version 167
>
> =C2=A0* add --level=3D<LIST> option to filter out messages, for example:
>
> =C2=A0 =C2=A0$ dmesg --level=3Ddebug,info
>
> =C2=A0 =C2=A0$ dmesg --facility=3Dkern --level=3Dwarn,err
>
> =C2=A0* add --clear option to clear the kernel ring buffer
>
> =C2=A0* add --read-clear to read and clear the kernel ring buffer
>
> =C2=A0* add --console-off and --console-on to control output to console
>
> =C2=A0* -n <LEVEL> (--console-level) supports human readable level names,
> =C2=A0 for example:
>
> =C2=A0 =C2=A0$ dmesg --console-level=3Demerg,alert
>
> Comments & suggestions?

Sounds all great. Thanks for adding this before people start
complaining that we fill the kernel log with 'userspace crap'. I
actually removed all syslog daemons from my systems, and use only
'dmesg' these days, and no log is stored on disk, I just don't need
it.

People ask since a while for an option to suppress the kernel's [...]
timestamp from the 'dmesg' output. Maybe you can make them happy too.
:)

Thanks,
Kay
