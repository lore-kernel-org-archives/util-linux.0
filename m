Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.9]:63779 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab1KPPFT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Nov 2011 10:05:19 -0500
Message-ID: <4EC3D12D.8090708@bernhard-voelker.de>
Date: Wed, 16 Nov 2011 16:05:17 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/15] prlimit: add warning diagnostic when attempting
 to change prlimit's limits
References: <4EC0735B.2010504@bernhard-voelker.de> <20111116124537.GD7916@nb.net.home>
In-Reply-To: <20111116124537.GD7916@nb.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11/16/2011 01:45 PM, Karel Zak wrote:
> On Mon, Nov 14, 2011 at 02:48:11AM +0100, Bernhard Voelker wrote:
>> >  +		if (lims[i].modify) {
>> >  +			if (!pid)
>> >  +				warnx(_("setting limits of the prlimit process is pointless"));
>
>   Well, I don't think that we want such warnings in our utils:-)  Let's
>   inform users about errors, the rest should be described in man pages.

hmm, then I tend to make it an error: prlimit acts too similar to
ulimit, but the *big* difference - and therefore the *big* trap for
the user - is that ulimit is a shell builtin which affects the current
shell process whereas prlimit runs in it's own process and, as a result,
will just do not have an effect without a PID.

Have a nice day,
Berny
