Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.mppmu.mpg.de ([134.107.24.58]:46955 "EHLO
	smtp.mppmu.mpg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab1H2Jkc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 29 Aug 2011 05:40:32 -0400
Date: Mon, 29 Aug 2011 11:21:00 +0200 (CEST)
From: Peter Breitenlohner <peb@mppmu.mpg.de>
To: Karel Zak <kzak@redhat.com>
cc: Pierre Gaston <pierre.gaston@gmail.com>, util-linux@vger.kernel.org
Subject: Re: example in flock manpage still not useful.
In-Reply-To: <20110829091804.GG1855@nb.net.home>
Message-ID: <alpine.LNX.2.00.1108291119400.2243@pcl321.mppmu.mpg.de>
References: <CAPSX3sTRT7zOZALF2CHUdgRuz3Gz4PyXtxmDB6nhVa7VwK7RDQ@mail.gmail.com> <20110829091804.GG1855@nb.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 29 Aug 2011, Karel Zak wrote:

> On Thu, Aug 25, 2011 at 03:26:14PM +0300, Pierre Gaston wrote:
>> flock -n 9 || exit 1                 # exit if the lock can't be acquire.
>
> Fixed. Thanks!

Shouldn't that be:
         # exit if the lock can't be acquired.

Regards
Peter Breitenlohner <peb@mppmu.mpg.de>
