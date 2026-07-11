Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A8D26ACC
	for <util-linux@vger.kernel.org>; Sat, 11 Jul 2026 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783809296; cv=none; b=rH33f2H53BhINUeBDQUk2i/2VArcdtOOew8ZcGWcu9eX4pE6rl7jM+pg3rrf1d8jQ92idbZZZOe+yB/HuTNTQMKOMITa8J7SSDRykp273hQ8bJQ4GBZeLZGVuW6qzhN536/gFofsw4RHYuL/pyTFow/hJum3chfqYDcAK2woxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783809296; c=relaxed/simple;
	bh=jhQjPty0O2ydvAsZ1nx2Z4XRM1JBQhU0HTAKDmV6Lh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7vNCCa9goTM/ExVILvtkhG0mws1hZVmX8l+8nX/9l7Y3fgEEJpI17dWRrcB6sADI2S+rwUtgQ3p8CO4eGrBpbw1atAi2M4be1i+tSPFPhhUJgbMgfrK5rFeq+RwG7wjMlP5uBzy8OwjS5g0vSk6gvW709hCSd83eAcUOuvhQU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QLjSbBtP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QLjSbBtP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=MT02yLL16ZtjtQ0o02J8EyXSPsUc+1JVZ3SOzwj2xh0=; b=QLjSbBtP3RHJFRBNXN4a30gfdM
	PVxZtXQZ5yvEZ6FqtFtllKrODG7JfEM3nzI95w61vS6ZK/UmSYdJ7qIiBUwbmOofiN9MRaUWYweXN
	EOFklePGlg1Lwa1bjG6Io1eSZnbH0jKcuvBYBhL1bgU6vzmA+4eQNVT1X7DUrkFdKhJz1uTfX5vN5
	/p9XjZun3MEJJMkx9qUTz6ooWUT+3Pdbx0WezeaWfRzb4qSGbVxoBcGbCONQO8WAm35KR22CjsRiW
	/K3zl9nNsH2HxKARcUea12nJqCHl2m4XPN/YvOlPKaeoN2Q066FFSILDfoT6CmKY3e82vjCsBcfAK
	IG+CCQYw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <zeha@debian.org>)
	id 1wigHV-000HUb-17;
	Sat, 11 Jul 2026 22:34:45 +0000
Date: Sat, 11 Jul 2026 19:34:41 -0300
From: Chris Hofstaedtler <zeha@debian.org>
To: util-linux@vger.kernel.org
Cc: Marc Lehmann <debian-reportbug@plan9.de>, 1141670@bugs.debian.org, 
	=?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Subject: Re: Bug#1141670: util-linux: very slow code and undefined behaviour
 in handle_interrupt
Message-ID: <alLEV6xOOwA1RzU_@zeha.at>
References: <178350371646.36377.6056214111743171473.reportbug@cerebro.laendle>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178350371646.36377.6056214111743171473.reportbug@cerebro.laendle>
X-Debian-User: zeha

Hi util-linux maintainers,

the following was reported to Debian, regarding the hardlink 
utility. It appears to be an upstream issue. Maybe someone can look 
at it. CC:ing наб who seems to have touched the relevant function 
last.

Thanks,
Chris

* Marc Lehmann <debian-reportbug@plan9.de> [260708 07:23]:
>Version: 2.41-5
>
>Dear Maintainer,
>
>while strace'ing to find out why hardlink is so slow, IO found it does this sequence between every fstatat call:
>
>   gettid()                                = 36482
>   getpid()                                = 36482
>   tgkill(36482, 36482, 0)                 = 0
>
>this seems to be a pretty weird thing to do in a tighht scanning
>loop. Looking at the code, handle_interrupt is responsible:
>
>   /**
>    * handle_interrupt - Handle a signal
>    */
>   static void handle_interrupt(void)
>   {
>           switch (last_signal) {
>           case SIGUSR1:
>                   print_stats();
>                   putchar('\n');
>                   break;
>           default:
>                   signal(last_signal, SIG_DFL);
>                   raise(last_signal);
>                   break;
>           }
>           last_signal = 0;
>   }
>
>this is already a weird function to begin with, but crucially, it calls signal(0,... and raise(0).
>
>it seems to me the former is likely undefined behaviour and the latter is
>just unnecessartily slow.
>
>most likely, handle_interrupt simply should not be called after every fstatat, or at all, without last_signal bering set beforehand.
>
