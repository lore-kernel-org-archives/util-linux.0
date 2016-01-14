Return-Path: bruce.dubbs@gmail.com
Subject: Re: Cyclic dependency with systemd?
To: Karel Zak <kzak@redhat.com>, Fredrik Johnsson <fredrik.johnsson@axis.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
References: <1452762264910.97373@axis.com>
 <20160114103158.rffxxsnkn466ofj5@ws.net.home>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <5697C9B5.8010103@gmail.com>
Date: Thu, 14 Jan 2016 10:15:49 -0600
MIME-Version: 1.0
In-Reply-To: <20160114103158.rffxxsnkn466ofj5@ws.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Thu, Jan 14, 2016 at 09:04:25AM +0000, Fredrik Johnsson wrote:
>> I have not run into any problems myself but can this be an issue? In
>> theory: If you compile systemd without util-linux, it should fail
>> because it needs libmount, and if you try to compile util-linux, it
>> should also fail because it needs sd_booted from libsystemd.
>
> The dependence on libsystemd is optional:
>
>   1/ build util-linux --without-systemd
>   2/ build systemd
>   3/ re-build util-linux --with-systemd
>
> anyway, people usually don't build all from scratch. If you already
> have system with all the dependencies then you can build without extra
> care about this issue.

For those of us who do build everything from scratch and choose to not use 
systemd, there is also a circular dependency on udev (we use eudev).  For 
our first build of util-linux we use --without-systemdsystemunitdir

   -- Bruce Dubbs
      linuxfromscratch.org
