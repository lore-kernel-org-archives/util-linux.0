Return-Path: kay.sievers@vrfy.org
MIME-Version: 1.0
In-Reply-To: <20120120.232002.849876084731555262.yamato@redhat.com>
References: <20120120140444.GC13157@x2.net.home> <20120120.232002.849876084731555262.yamato@redhat.com>
From: Kay Sievers <kay.sievers@vrfy.org>
Date: Fri, 20 Jan 2012 15:56:43 +0100
Message-ID: <CAPXgP10uUpSQzX0RzYY24uDBkNkRXM7NbR0H6P=dZ=+LxdX3Fw@mail.gmail.com>
Subject: Re: /etc/fstab.d yes or not
To: Masatake YAMATO <yamato@redhat.com>
Cc: kzak@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 20, 2012 at 15:20, Masatake YAMATO <yamato@redhat.com> wrote:
>>
>> =C2=A0I'd like to add support for /etc/fstab.d to libmount. The library =
is
>> =C2=A0currently used by mount, umount and mount.nfs. The goal is to use =
it
>> =C2=A0on more places.
>>
>> =C2=A0The /etc/fstab.d directory has been requested by people who mainta=
ins
>> =C2=A0large number of mountpoints etc.
>>
>> =C2=A0The directory is not replacement for /etc/fstab, it's additional p=
lace
>> =C2=A0where you can describe your filesystems.
>>
>> =C2=A0The disadvantage is that the stuff in the directory will be invisi=
ble
>> =C2=A0for some tools (udisks, systemd, ...), so I have very vocal
>> =C2=A0disagreement from some people who don't want to see /etc/fstab.d a=
t all.
>
> I'm working on systemd to support /etc/fstab.d.

And we don't want to support that in systemd.

It's an old glibc API, and /etc/fstab is ABI, not a service config
file, which now can read more than one file. It's a very different
problem. It an ABI change, not a config extension.

Tools rightfully expect that they find all system mounts in that file,
and not in some new split-up directory. In some cases, fstab is used
to 'check if the device is not a system volume', and that will just
break now,

The gain of features from fstab.d/ vs. the amount of breakage it
causes is not worth the trouble.

And yes, there are systemd units, but we don't recommend anybody
working with a general purpose system to mount system volumes with
them. They are primarily used for virtual filessytems, which do not
belong in fstab. In special purpose setups, like embedded, which do
not care about POSIX-like APIs, the systemd units can replace fstab,
but it's an entirely different story than breaking fstab expectations.

Kay
