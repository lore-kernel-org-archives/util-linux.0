Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.187]:62995 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab2HGIXV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Aug 2012 04:23:21 -0400
Message-ID: <5020D072.80405@bernhard-voelker.de>
Date: Tue, 07 Aug 2012 10:23:14 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: faizan husain <faizanh@linux.vnet.ibm.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu : -b and -c option does not give expected output.
References: <1344229852-4737-1-git-send-email-faizanh@linux.vnet.ibm.com> <20120806114906.GA3432@osiris.de.ibm.com> <5020A7F8.9070402@linux.vnet.ibm.com> <20120807073509.GA31284@osiris.de.ibm.com>
In-Reply-To: <20120807073509.GA31284@osiris.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 08/07/2012 09:35 AM, Heiko Carstens wrote:
> What I tried to say above was that the -a, -b and -c modifiers were
> only added to influence the output for the extended and parsable
> options.

If -a,-b,-c are not to be used with OUTPUT_SUMMARY, then what about
giving an error message when they are used together?

Have a nice day,
Berny


