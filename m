Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFAB1BD9C2
	for <util-linux@vger.kernel.org>; Tue, 10 Dec 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843912; cv=none; b=QRDgcpIUAIQbNNECM8w0vWpZLHSqGKwTKWH20CG6Hfp0wxguTV+fn1bwqqkXGuYAn3k8bVl/DVvebXOV8gpiNTo9x807RVs7P/zs1Uk6OpkqSeS4/O+stC0I9chPmUGmHQYvjLVuU6E0doLuj+tM/LcFjQr/+lVAUL6aa4rAbvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843912; c=relaxed/simple;
	bh=nEGx1xBTgNhSlnlkpszUx+TQabUsxdplc8sLY8QOxhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRzHWX9K1KlIh730zaij3xPv4HDCwV/iTrtJU9AiJcwp4kLvhieix4PjsCZfkiYbeDbfZBlPtO+lOwg+nygADQBk11BeHhmQyi3RCd0GfKbx2cWvd9fHyT6z3b7z5LzX/myT5GXdWSe9n58oM901FxTW1LYUofS0u2K8uvvb8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=e1oM5hAL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="e1oM5hAL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=aAvARnWINDf0grV/zMud6ONDvWvlMlfs989voimlRco=; b=e1oM5hALh41NxM8GJ2TO985vgi
	eQp9bTJS+d1RM9IzPg9qXPJSYCuYkeHrSqrFiEogozroBmJdy3uz8Vk1YfnmXcnV5h9vgOXBg4A5w
	VOF9oeYcShxXXLMUv+H1seP13HqxkFpD5S8q1pXy1gXSBiIDhWwY5ysudWlBXhl9bBNN77Wx0/nld
	eKJwSPBQB9qvp0l9fQ9s2CrjlEme6/pwdbt1UI05C6/XfdssaYAtVJ1Jz64uEOgLqSvus0rZ3H+KY
	T2dA+KVI3ttLmZnQr75u3e74OHkfhMA+hYOfzkCJ3AAA7fwt6d1rpHL/vjUBKn9Z8MTW9XAqLy049
	H3oN0lew==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1tL1mA-006wnr-Us; Tue, 10 Dec 2024 15:03:51 +0000
Date: Tue, 10 Dec 2024 16:03:49 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: Re: v2.40.3 plan
Message-ID: <tcyqzu65my54wgqt4twjcdtb5vayvoojareuzkfnbx6pev7osa@lhea5femzoia>
References: <4wnkdjqtwlx5pjeknj7wqmk5bgftoyzpqijqguekcepcdyrgmn@pofpabk4awvg>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4wnkdjqtwlx5pjeknj7wqmk5bgftoyzpqijqguekcepcdyrgmn@pofpabk4awvg>
X-Debian-User: zeha

Hi Karel,

* Karel Zak <kzak@redhat.com> [241210 12:45]:
> Please refer to the following link for the current patches in the
> branch: https://github.com/util-linux/util-linux/commits/stable/v2.40/
> 
> If there is anything missing or if you would like to add something to
> the release, please let me know.

I think it would be nice to add the following three commits from
master; they either apply as is or with an automatic merge done by
git:

  commit 6227b2b0585ee2ccf224cf70c7144296a814a4ab
  Author:     Thomas Weißschuh <thomas@t-8ch.de>
  AuthorDate: Tue Apr 9 11:00:26 2024 +0200
  Commit:     Thomas Weißschuh <thomas@t-8ch.de>
  CommitDate: Tue Apr 9 11:10:16 2024 +0200
  
      logger: correctly format tv_usec
  
      tv_usec is an unspecified signed integer type.
      The format string %u assumes an unsigned int, which is incorrect.
      Especially on 32bit big-endian, where it can lead to invalid values.
  
      Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
      Link: https://lore.kernel.org/util-linux/afef1b770ad80d50660bb2c53a0a8330b88d1049.camel@physik.fu-berlin.de/
      Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
  
  commit 5ebf0edb0a0531cba801c7791543c610725bf944
  Author:     Chris Hofstaedtler <zeha@debian.org>
  AuthorDate: Tue Apr 9 10:34:59 2024 +0200
  Commit:     Karel Zak <kzak@redhat.com>
  CommitDate: Tue Apr 9 13:48:37 2024 +0200
  
      audit-arch.h: add defines for m68k, sh
  
      John Paul Adrian Glaubitz points out that libseccomp needs to release 2.6.0,
      too.
  
      Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
      Reviewed-by: Thomas Weißschuh <thomas@t-8ch.de>
      Signed-off-by: Chris Hofstaedtler <zeha@debian.org>
  
  commit 6fc5b5af4bfea4e3115cddb2c1716b3120bb3d4f
  Author:     Karel Zak <kzak@redhat.com>
  AuthorDate: Thu Jul 11 13:26:30 2024 +0200
  Commit:     Karel Zak <kzak@redhat.com>
  CommitDate: Thu Jul 11 13:26:30 2024 +0200
  
      agetty: add "systemd" to --version output
  
      Signed-off-by: Karel Zak <kzak@redhat.com>


> The next release, v2.41-rc1, is expected to be released at the end of
> December or in January.

Good to know. There is no release timeline yet for Debian trixie, so
depending on that and when you think 2.41 final might arrive, we
could ship with 2.41. If you have any input on that, please let me
know.

Thanks!
Chris

