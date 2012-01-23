Return-Path: yamato@redhat.com
Date: Mon, 23 Jan 2012 23:14:43 +0900 (JST)
Message-Id: <20120123.231443.486973746541575934.yamato@redhat.com>
To: kay.sievers@vrfy.org
Cc: kzak@redhat.com, rleigh@codelibre.net, util-linux@vger.kernel.org,
        ssato@redhat.com
Subject: Re: /etc/fstab.d yes or not
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <CAPXgP10LHyDJt_v5w1JyY4q0ouunVxJHr3QLgdL5VBPG28qOBQ@mail.gmail.com>
References: <CAPXgP11WMG1Q53scWXqQnktOyUZbY5K09KRfRaT3ct-Y78yULA@mail.gmail.com>
	<20120123.222636.550210626606480400.yamato@redhat.com>
	<CAPXgP10LHyDJt_v5w1JyY4q0ouunVxJHr3QLgdL5VBPG28qOBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <util-linux.vger.kernel.org>

On Mon, 23 Jan 2012 14:37:22 +0100, Kay Sievers <kay.sievers@vrfy.org> wrote
>> What I want is packaging the system mounts.
>> Consider setting up multiple hosts which mount the same nfs filesystem
>> to the same mount point. It the mount point is in a rpm package, it
>> can be used both in kickstart file and from yum command line. In
>> addition yum update can be used when the name or ip of nfs server is
>> changed; Just create the new release of the rpm package which holds
>> new mount point deification. In stead of nfs, you can consider smb or
>> iso images as examples.
> 
> That sounds very wrong to do. This is admin territory and not package
> management. 

I'm thiking about the admin manages packages which are installed to 
the host.

> There are tools sync and deploy /etc setting per-machine
> across big networks, and RPM is surely not the right thing to use
> here.

(RPM works fine daily "yum update" done by users on the world.)
Of course I'm thinking about the admin runs her/his own yum repository.

> RPM is for the operating system, not for host configuration. Most
> stuff in /etc is marked as config for that exact reason. First, static
> system-config does not belong in /etc, second non-admin editable files
> just do not belong in /etc. It's all wrong, just as the misguided
> entire fstab.d/ feature to start with.

It is not so simple.

$ rpm -qf /etc/yum.repos.d/fedora.repo 
fedora-release-14-1.noarch

Admin can edit fedora.repo, but generally it is assumed as static
file. 

$ rpm -q --queryformat "%{NAME}: %{FILEFLAGS:fflags}\n" -f /etc/udev/rules.d/*.rules
hplip-common: 
hplip-common: 
libfprint: 
qemu-system-x86: 
alsa-utils: 
hal: c
libdrm: c
vbetool: 
bluez: 
fuse: 
gpsd: cn

Some are marked as config as you said. The other are not. I think the packages
may think their rules files as static data.

Masatake YAMATO
