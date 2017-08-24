Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 5/6] hwclock: rename/refactor set_system_clock()
To: Karel Zak <kzak@redhat.com>
References: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
 <ab175fb6-72c2-c3a4-5f72-fa0600c2b13d@gmx.com>
 <20170821093158.2kmbowciuklu47yc@ws.net.home>
 <113d8ff2-e593-675b-5ef2-21e15d5cea98@gmx.com>
 <20170822090457.xd65avktdmp6z76e@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <be6b5f0b-d3b9-75a5-b5f5-5f6c8ec16e08@gmx.com>
Date: Thu, 24 Aug 2017 19:35:35 -0400
MIME-Version: 1.0
In-Reply-To: <20170822090457.xd65avktdmp6z76e@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 08/22/2017 05:04 AM, Karel Zak wrote:
> On Mon, Aug 21, 2017 at 08:56:41AM -0400, J William Piggott wrote:
>>

 8< ...

> 
>> It doesn't matter to me, I was changing it to help others. Do you want me
>> to put it back to set_system_clock?
> 
> Please, or try something better (set_time(), set_kernel_time(), ...).

Kept the original name set_system_clock and pushed to the same branch:

The following changes since commit ebfab541cf1266bf80b2b62977cf29ff69c61fe1:

  fdisk: add missing include (2017-08-24 19:59:20 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170803

for you to fetch changes up to e406be01b450dd7ed5e694bc15a39719d6f86967:

  hwclock: for debugging print startup system time (2017-08-24 18:49:11 -0400)

----------------------------------------------------------------
J William Piggott (6):
      hwclock: move systz into hctosys
      hwclock: remove set_system_clock_timezone()
      hwclock: update set_system_clock debugging
      hwclock: update set_system_clock comments
      hwclock: refactor set_system_clock()
      hwclock: for debugging print startup system time

 sys-utils/hwclock.c | 182 ++++++++++++++++++----------------------------------
 1 file changed, 61 insertions(+), 121 deletions(-)


> 
>     Karel
> 
