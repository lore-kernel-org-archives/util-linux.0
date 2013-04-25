Return-Path: linux-kernel-owner@vger.kernel.org
Message-ID: <51795B09.9040908@gmail.com>
Date: Thu, 25 Apr 2013 18:34:17 +0200
From: Milan Broz <gmazyland@gmail.com>
MIME-Version: 1.0
To: Andi Kleen <andi@firstfloor.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux 2.23
References: <20130425110450.GF2244@x2.net.home> <m2haiuvj2o.fsf@firstfloor.org>
In-Reply-To: <m2haiuvj2o.fsf@firstfloor.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 25.4.2013 15:25, Andi Kleen wrote:
>> Util-linux 2.23 Release Notes
>> =============================
>>
>> The cryptoloop support in the commands mount(8) and losetup(8) has been
>> REMOVED. The encryption= mount option and -e,-E,--encryption losetup options
>> are no more supported.
> 
> That's crazy. You're taking away access to existing data.

Nope. You can use cryptsetup.

https://lkml.org/lkml/2012/11/2/162

Milan
