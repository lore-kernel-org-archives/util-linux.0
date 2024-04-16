Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF2A13956B
	for <util-linux@vger.kernel.org>; Tue, 16 Apr 2024 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713297616; cv=none; b=XRSwPCQHHq7Q6CCYo2QZLNQwtP1Ku7iPHlxTVdIFIgqbyFidvQFk+xCZ0BAxsvGgUmui3S3xpZT+SvU0XFWOixM5hwQc3ep2W7IeZsA2icF62MNWcaWJNCceQPjnsv5r2CSrmC9VQPAhAmYhlnHEqSL0YN/oi0Ca9KBRYXB7oV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713297616; c=relaxed/simple;
	bh=KcQLITFHrJOJlhI061sAL7GRaQZgTd2oFj0Rn+XGFF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1s5e4lABBPAWF/tamk9iofPAjlDvAqWDBw+Os0Sd7BuF+bweiefWl1CiXZ8nlkRsS/J2Jw9U6jM1G0Q4/Diu8pLTM72SUnKgoz7N/5SaX3lTpi+EzkFtD7fxz9df5dNxclcVwYVGJIrQszpJjx98q+nJsmkzdSvCLpEC1nxJWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=ngMSbF9V; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="ngMSbF9V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1713297611; bh=KcQLITFHrJOJlhI061sAL7GRaQZgTd2oFj0Rn+XGFF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ngMSbF9VHetZfEcSI6N9OyE1v3JgZ28V/E6EpU1oCPYrqodZPUC/kQexzjJojvaDt
	 I86PnW5FcXkp5GaJ6Gd9JAobO6mlJU8hGiDmClbVxbUvCxUACH2gJdk0pJxujIfsbC
	 jOKi3OYXC0TSyL82D6RBs/KwUgQ8ioLVbseQvsOY=
Date: Tue, 16 Apr 2024 22:00:10 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Masatake YAMATO <yamato@redhat.com>, util-linux@vger.kernel.org
Subject: Re: lsfd/error-eperm test fails on git master
Message-ID: <31e05ad7-78d2-4658-a1fb-77313f7d16ba@t-8ch.de>
References: <31ccace2e5912ffc428e065cd66764088c625c4d.camel@physik.fu-berlin.de>
 <20240416.092958.1925095964872687612.yamato@redhat.com>
 <873299ec-913a-43a8-ac11-20ca4b03f2f7@t-8ch.de>
 <ed956683-5b2e-4eb5-9056-8c8eedf1c17c@t-8ch.de>
 <051624b9256db27a731d62c031cb627d9f5a256e.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <051624b9256db27a731d62c031cb627d9f5a256e.camel@physik.fu-berlin.de>

On 2024-04-16 10:57:20+0200, John Paul Adrian Glaubitz wrote:
> Hi Thomas,
> 
> On Tue, 2024-04-16 at 09:38 +0200, Thomas Weißschuh wrote:
> > > I can send a patch but wanted to wait for the original submitter.
> > 
> > Should be fixed by https://github.com/util-linux/util-linux/pull/2960
> 
> That doesn't seem to be 100% compatible with the default awk on Debian:

I switched over to sed, could you try that?

https://github.com/util-linux/util-linux/pull/2964

>   CC       lib/agetty-plymouth-ctrl.o
> mawk: line 1: syntax error at or near ,
>   CC       login-utils/sulogin.o
