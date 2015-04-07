Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.130]:49665 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbbDGGgi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Apr 2015 02:36:38 -0400
Message-ID: <55237AF1.3010004@bernhard-voelker.de>
Date: Tue, 07 Apr 2015 08:36:33 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>, Patrick Plagwitz <patrick.plagwitz@fau.de>
CC: util-linux@vger.kernel.org
Subject: Re: logger: Segmentation fault when reading from stdin and writing
 to socket
References: <5521E92D.2090404@fau.de> <alpine.LNX.2.03.1504062226540.593@iki.fi>
In-Reply-To: <alpine.LNX.2.03.1504062226540.593@iki.fi>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/06/2015 11:50 PM, Sami Kerola wrote:
> On Mon, 6 Apr 2015, Patrick Plagwitz wrote:
>> The attached patch does just that.

> The below appears to fix the issue. 

Sami, your patch differs from Patrick's just in a newline, and you only
turned his - already great - description into a commit message.
Therefore I think setting Patrick as the author would be both correct
and just fair.

Please note that seeing the own name in the commit log encourages
people to continue contributing in future.

BTW: what about the memleak he reported?

Thanks & have a nice day,
Berny

