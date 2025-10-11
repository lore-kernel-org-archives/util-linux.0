Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F3B142E83
	for <util-linux@vger.kernel.org>; Sat, 11 Oct 2025 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760177830; cv=none; b=lVS/INgDg8WWXxMcSnC/WxR9D0jRon4b0gkoCgGK4aye8xcvB2z18QR7kT1GnrtiITt45V3RmjXMVMeHTdFayXsWsRAIw/c+cTg6dXK5RQKnqhJflm4SdUnW/0QXFTDR6CJl7+NruQpl7ps5XqwJxXkxLDrqC7ZKC+3+X65M7Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760177830; c=relaxed/simple;
	bh=BXcel0b+4yfDQejaoRiY+q/T977ht0wnJRRip2ru9Pc=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=BJBz8jw+zwtzjkzgM/QOW2Mtqv+puyi4BtKtcoUFVKhwfaxEvCJhbwoJVjRMjMag4leu8N+niQ1g3Pn+rbABriT+LJtUMD0SB4zYNWsUBOCTHdAup9lJWoqH6zYmCpxDUixu+pOioCs0MtcmXi3JndxC/tA1TQaDjjSg1GpLT7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ist.utl.pt; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ist.utl.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gcuu-util-linux-ng-3@m.gmane-mx.org>)
	id 1v7Wel-0008cF-1Y
	for util-linux@vger.kernel.org; Sat, 11 Oct 2025 12:16:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: util-linux@vger.kernel.org
From: Nuno Silva <nunojsilva@ist.utl.pt>
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
Date: Sat, 11 Oct 2025 11:16:45 +0100
Message-ID: <10cdaqe$vrk$1@ciao.gmane.io>
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)

On 2025-10-10, Benno Schulenberg wrote:

> After setting up a loop device with:
>
>   # ./losetup loop4 some.img
>
> I wanted to see what happens when trying to "remove" it
> (since the man page says it is "not recommended"):
>
>   # ./losetup -R loop4
>
> There is no feedback, but it failed:
>
>   # echo $?
>   1
>
> When a command fails, shouldn't it print an error message?

For all commands after this one in your message, where there was no
output, what was the exit status?

[...]
> Trying a different order of the options:
>
>   # ./losetup -d -R loop4
>   losetup: /dev/-R: detach failed: No such file or directory
>
> Huh?  Why does it try to interpret an option as a loop device name?

The online manual here says that -d takes one argument, so my
understanding is that that is expected? (Just as for -R, apparently:)

>   # ./losetup -d loop4 -R
>   /home/ben/Sources/util-linux/.libs/losetup: option requires an argument -- 'R'
>   Try 'losetup --help' for more information.
>
>   # ./losetup -d loop4 -R loop4
>
> Oh.  Surprisingly, this last invocation worked.

[...]

-- 
Nuno Silva

