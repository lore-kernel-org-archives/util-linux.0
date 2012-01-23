Return-Path: yamato@redhat.com
Date: Mon, 23 Jan 2012 22:26:36 +0900 (JST)
Message-Id: <20120123.222636.550210626606480400.yamato@redhat.com>
To: kay.sievers@vrfy.org
Cc: kzak@redhat.com, rleigh@codelibre.net, util-linux@vger.kernel.org,
        ssato@redhat.com
Subject: Re: /etc/fstab.d yes or not
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <CAPXgP11WMG1Q53scWXqQnktOyUZbY5K09KRfRaT3ct-Y78yULA@mail.gmail.com>
References: <CAPXgP11pvch92n1=mMfDsMLoGZMG8xq0e1juXyUO6mxFR6_GYg@mail.gmail.com>
	<20120123122115.GA29250@x2.net.home>
	<CAPXgP11WMG1Q53scWXqQnktOyUZbY5K09KRfRaT3ct-Y78yULA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
List-ID: <util-linux.vger.kernel.org>

On Mon, 23 Jan 2012 14:03:41 +0100, Kay Sievers <kay.sievers@vrfy.org> =
wrote
> On Mon, Jan 23, 2012 at 13:21, Karel Zak <kzak@redhat.com> wrote:
>> On Fri, Jan 20, 2012 at 06:59:47PM +0100, Kay Sievers wrote:
>>> > Inventing custom file formats for these (as is the current situat=
ion)
>>> > is both opaque to the admin and less amenable to preservation/upg=
rading
>>> > of the admins customisations and the defaults.
>>>
>>> I'm not talking about custom file formats, better just add a mount =
-c,
>>> and do mount -c /etc/kernelfs.d/*.conf, or whatever will fit system=
v
>>> needs.
>>
>> =A0This is planned (I talked about it on dracut list few months ago)=
. It
>> =A0means:
>>
>> =A0 =A0mount --fstab=3D<path> /mountpoint
>>
>> =A0to override the default /etc/fstab path. The <path> could be also=
 a
>> =A0directory. So you can maintain our mountpoints in multiple files =
and
>> =A0mount(8) will be able to search in the files if --fstab=3D<path> =
is
>> =A0explicitly specified. I think this should be enough for initramfs=

>> =A0scripts.
>>
>> =A0The problem is that the configuration won't be visible if
>> =A0--fstab is not specified -- this is possible to resolve probably
>> =A0by regular /etc/fstab.d only ;-)
> =

> It creates many times more problems that anybody has today.
> =

>>> This is nothing really to share between systemd and systemv here. T=
his
>>> problem just does not exist for systemd.
>>
>> =A0Well, Masatake has RHEL customers who want to deploy systems with=

>> =A0rpm/yum, %post scripts are poor solution because it's not too
>> =A0reliable and verification with rpm -V doesn't work. Do we have an=
y
>> =A0answer for this use case?
> =

> We don't need one. System mounts just do not belong into packages,
> they are mandatory and hard-coded, or set by the admin and
> host-specific configured, and never to be dropped by RPM. RPM is not
> to be used for host-only system config.

What I want is packaging the system mounts.
Consider setting up multiple hosts which mount the same nfs filesystem
to the same mount point. It the mount point is in a rpm package, it
can be used both in kickstart file and from yum command line. In
addition yum update can be used when the name or ip of nfs server is
changed; Just create the new release of the rpm package which holds
new mount point deification. In stead of nfs, you can consider smb or =

iso images as examples. =


Masatake YAMATO
 =

> Kay
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
