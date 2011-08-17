Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.187]:65263 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab1HQPBZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 17 Aug 2011 11:01:25 -0400
Message-ID: <4E4BD7C0.2040205@bernhard-voelker.de>
Date: Wed, 17 Aug 2011 17:01:20 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: losetup --all --verbose results in usage
References: <4E4BCC65.2060100@bernhard-voelker.de> <20110817144433.GD699@nb.net.home>
In-Reply-To: <20110817144433.GD699@nb.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/17/2011 04:44 PM, Karel Zak wrote:
> On Wed, Aug 17, 2011 at 04:12:53PM +0200, Bernhard Voelker wrote:
>> I was surprised that running
>> 	mount/losetup --all --verbose
>> results in usage().
>
>   Fixed. losetup -a -v works now.
>
>      Karel

uh, that was fast.
Thanks.

Berny
