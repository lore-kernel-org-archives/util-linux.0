Return-Path: ndevos@redhat.com
Message-ID: <5019017E.4050704@redhat.com>
Date: Wed, 01 Aug 2012 12:14:22 +0200
From: Niels de Vos <ndevos@redhat.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [RFC] mount: overwrite options from /etc/fstab when given on
 the commandline
References: <1343812301-24896-1-git-send-email-ndevos@redhat.com> <20120801094833.GC1019@x2.net.home> <20120801100316.GD1019@x2.net.home>
In-Reply-To: <20120801100316.GD1019@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 08/01/2012 12:03 PM, Karel Zak wrote:
 > On Wed, Aug 01, 2012 at 11:48:33AM +0200, Karel Zak wrote:
 >>> Some options are not allowed to be
 >>> passed multiple times (like the SElinux context options) and mounting will fail
 >>> if options are present in both /etc/fstab and on the commandline.
 >>
 >> This is stupid SELinux disadvantage and SELinux should be fixed.
 >
 > Note that mount(8) and libmount removes all selinux context options on
 > remount for kernels<  2.6.39 because SELinux context remount was
 > unsupported, so this SELinux disadvantage should be hidden for usual
 > use case.
 >
 > Maybe we can also add another exception for SELinux to de-duplicate
 > the SELinux context options in the options string. It's not perfect,
 > but probably acceptable for SELinux -- I can do this for 2.22-rc2.

That would be great. What is your opinion on getting the SElinux options
handled differently in the kernel instead or in addition? If the kernel
would allow multiple SElinux options (and only the last gets applied) would
you still be interested in adding this SElinux exception?

Thanks again,
Niels
