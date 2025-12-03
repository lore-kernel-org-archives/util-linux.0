Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1840398F88
	for <util-linux@vger.kernel.org>; Wed,  3 Dec 2025 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764795030; cv=none; b=gVV0ErYiuz5pXNd9INrwrNnW8CEg7oDzkYg5QLIyCNv5j7dFTJX2h8Y7IZxNz4KjjqGkwV7znrCxeQjb3xCmIRfCzVVxbmzLVhvSh8xsN79aWqX154hCfu2NAAdH4rqdqYliyQJpK4ZWfcDpZrjRdoUL2HBjL2KlHbrqVbeYsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764795030; c=relaxed/simple;
	bh=JPWHIvXvsdaCgvZqK2/pArqIAaFMRUQdhjX6hnckzsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n01hI0jXvohnKB3clHKvQ9yVoFe9Ido22cIwCLcA8b5+MouqRL/U7WLP1QzvSAdq1NKfPTmF4Nhp/e+4O4k0whIk8hqq7pIF9s1/TVyILwHJYF17AlikLTVdt2Y7RHLADZmN5w6tXZfuwneGeOF6W3RM8y0BMLPib+sJO8atrv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czKoHVem; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czKoHVem"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1B3C4CEF5;
	Wed,  3 Dec 2025 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764795030;
	bh=JPWHIvXvsdaCgvZqK2/pArqIAaFMRUQdhjX6hnckzsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czKoHVemxSy3m6u++xgChw9PqSO1yGxTpRK+u4ir+YTku3TyX/0kPxJJ0GdjlPokR
	 QX8XHGgAEUwwt3gJbOyeB/15Y10x9ameb2jJYYwds5mwJLdsPdp56acmSwRZCRUyYF
	 c8mh4DihLURMxUIg6HQ2cz+RMDBL/Nm4eDBSTz3z2qY62cSm8ztw2ULG+O67I6oi7X
	 cbHs42OnAhkmb0jNfZFiV8x0RdM3AhPNZwBB+Mx7BIs1Xx0039bVZqv0OGShRGhzI/
	 TM88DpGwabvHrj3ln2nN9z608Hl23t4sVMRdqm1cGYA7Htcv7NnUKT3Ls3SsOP9vzZ
	 K7nf40ZWZk+nw==
Date: Wed, 3 Dec 2025 21:50:27 +0100
From: Alejandro Colomar <alx@kernel.org>
To: util-linux@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Xi Ruoyao <xry111@xry111.site>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, Karel Zak <kzak@redhat.com>
Subject: [PATCH v2 0/1] Call prctl(2) with signed long integers, and avoid
 casts
Message-ID: <cover.1764794880.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
References: <20240601093150.16912-1-alx@kernel.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240601093150.16912-1-alx@kernel.org>

Hi!

Karel reminded me of this old patch.  Here's a revision of the patch.
Major changes in v2:

-  Don't specify the 5 arguments unnecessarily.

BTW, I've developed a header file that might be useful for the general
public.  See in a reply to this mail.


Have a lovely night!
Alex

Alejandro Colomar (1):
  c4fc41abf Call prctl(2) with signed long integers, and avoid casts

 lib/caputils.c               |  6 +++---
 lib/env.c                    |  4 ++--
 misc-utils/enosys.c          |  2 +-
 schedutils/coresched.c       |  6 +++---
 sys-utils/setpriv-landlock.c |  2 +-
 sys-utils/setpriv.c          | 27 +++++++++++++--------------
 tests/helpers/test_mkfds.c   |  2 +-
 7 files changed, 24 insertions(+), 25 deletions(-)
-- 
2.51.0

