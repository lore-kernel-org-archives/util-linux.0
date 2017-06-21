Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 11/12] hwclock: remove unused usage() FILE argument
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <ce8ce9d6-d266-12da-8e7e-c41e6a185714@gmx.com>
 <20170620085610.5eacn7kl5agfemmk@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <3329fb6f-1916-f2e1-a720-91833a146794@gmx.com>
Date: Tue, 20 Jun 2017 20:52:32 -0400
MIME-Version: 1.0
In-Reply-To: <20170620085610.5eacn7kl5agfemmk@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 06/20/2017 04:56 AM, Karel Zak wrote:
> On Sun, Jun 18, 2017 at 08:49:49PM -0400, J William Piggott wrote:
>>  sys-utils/hwclock.c | 74 ++++++++++++++++++++++++++---------------------------
>>  1 file changed, 37 insertions(+), 37 deletions(-)
> 
> It would be better to remove this patch from the pull-request; let's
> keep fputs() in the code and wait for any solution from Rudi :-)

Dropped.

> 
> It's bad ideal to introduce any local (hwclock-only) solution right
> now.
> 
>     Karel
> 
