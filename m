Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E01168B06
	for <util-linux@vger.kernel.org>; Fri, 26 Apr 2024 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714154622; cv=none; b=Q74eBE2fXlQpoQ0t59khDjcwZyA5uEFQJjYG/To59CwhBeUbQ3fMotKTFus/TW0ok6GWItaGwEl9tBVR1A+ROFxo5As58BvicFohJDD8wrd4czG2CcOUyPZ3xjsMLWBMdqeCH7nmJIljFK3J0vTLJGDp0Jw9zfQ0DQmXxHoR/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714154622; c=relaxed/simple;
	bh=jzGY76BJLhU/z8W6TWwpn5mVckcL3sYELMbbuZ0Nz30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxaUHSNfpfEB/KnaJ/DgWa1NjnRlMSIxdnTShlDAcrJ7+pl6OZ25WmgvKH3XkO/d7fkEJ8M9JtebXLvHtvQjVky18nVcnayVcJu0Qwhpi7HRdNHmIw4H5H5hWSdma07OQdSBAKaXXizzj/0EHzOg1mU6qqC2/jyhWZWXpG5u8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=bkYJN2GU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="bkYJN2GU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1714154616; bh=jzGY76BJLhU/z8W6TWwpn5mVckcL3sYELMbbuZ0Nz30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkYJN2GUxGXwQObOqDPZQtAu38ig/XsydgQxBXAlBjrHqPRI1brFv3t8YBblHriyx
	 NjgFtsRT4vtSN9Bk4uQSNqHC9N2BV1EtsCXA8PJvYfNecwsGy5u4QVVJQLPSKv3Ytm
	 mnr9Lza4E5v3l8Ws9FdHxRcyXMVvty5d51L87LwE=
Date: Fri, 26 Apr 2024 20:03:35 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Thijs Raymakers <thijs@raymakers.nl>
Cc: kzak@redhat.com, util-linux@vger.kernel.org, 
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v12] coresched: Manage core scheduling cookies for tasks
Message-ID: <73694be2-6215-4baf-8bfa-573cfc2dbfb7@t-8ch.de>
References: <295323c3-a43a-4f60-9c71-3b38a19b1d6f@t-8ch.de>
 <20240425162226.130639-1-thijs@raymakers.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240425162226.130639-1-thijs@raymakers.nl>

Thanks for all the work.

On 2024-04-25 18:22:25+0000, Thijs Raymakers wrote:
> Co-authored-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Thijs Raymakers <thijs@raymakers.nl>

Reviewed-by: Thomas Weißschuh <thomas@t-8ch.de>

> ---
> 
>  .gitignore                                    |   1 +
>  bash-completion/coresched                     |   0

Don't forget this :-)

>  configure.ac                                  |  12 +-
>  meson.build                                   |  16 +-
>  meson_options.txt                             |   2 +-
>  schedutils/Makemodule.am                      |   8 +
>  schedutils/coresched.1.adoc                   | 139 +++++++
>  schedutils/coresched.c                        | 363 ++++++++++++++++++
>  tests/commands.sh                             |   1 +
>  .../coresched-copy-from-child-to-parent       |   1 +
>  ...coresched-copy-from-parent-to-nested-child |   1 +
>  .../schedutils/coresched-get-cookie-own-pid   |   1 +
>  .../coresched-get-cookie-parent-pid           |   1 +
>  .../coresched-new-child-with-new-cookie       |   1 +
>  .../coresched-set-cookie-parent-pid.err       |   1 +
>  .../expected/schedutils/set-cookie-parent-pid |   1 +
>  tests/ts/schedutils/coresched                 |  83 ++++
>  17 files changed, 626 insertions(+), 6 deletions(-)
>  create mode 100644 bash-completion/coresched
>  create mode 100644 schedutils/coresched.1.adoc
>  create mode 100644 schedutils/coresched.c
>  create mode 100644 tests/expected/schedutils/coresched-copy-from-child-to-parent
>  create mode 100644 tests/expected/schedutils/coresched-copy-from-parent-to-nested-child
>  create mode 100644 tests/expected/schedutils/coresched-get-cookie-own-pid
>  create mode 100644 tests/expected/schedutils/coresched-get-cookie-parent-pid
>  create mode 100644 tests/expected/schedutils/coresched-new-child-with-new-cookie
>  create mode 100644 tests/expected/schedutils/coresched-set-cookie-parent-pid.err
>  create mode 100644 tests/expected/schedutils/set-cookie-parent-pid
>  create mode 100755 tests/ts/schedutils/coresched


