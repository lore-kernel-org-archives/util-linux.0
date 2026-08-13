Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE83054EF
	for <util-linux@vger.kernel.org>; Thu, 13 Aug 2026 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632343; cv=none; b=CvaEYmyFTB5l5UGSXNAp7MqA+nBzHlJqjeR6Y2KaK/dGJsUn0rc/zsPNnhb4bgTduNb8OIOvHdGmmTz5UyzldLn0lEqziIg5AHC6W3RKXjUBkOijo7hyujA/Pr974g7MTbKfAQ1IQQpx+XzTbWzaqJkRZNj8SVaJPOp9DJ6+o7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632343; c=relaxed/simple;
	bh=EDwHPv5UJDeb0QLsSxEEen0VnnSE4bN2EGHQoi0Omak=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bdibv68bJRJS2Mt9xQCJukpt75mabssWpb1KtBU7EeH7/emRE05+XsjCucXGUxfwgvF24f9X68ZkzwSjmuAQ6U7REZ3+6HEATu5qXbWeQRRfABwlvpWR/f7bSvk6jKS654Upk99UvIT2Xc7yQ3Knqgb9JjVw6r3Yraonkv9/Q+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDDBWhEk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDDBWhEk"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d032846c95so26793545ad.1
        for <util-linux@vger.kernel.org>; Thu, 13 Aug 2026 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632341; x=1787237141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Or9PP7IwqRPVBd8HQX8kQHcQn2EW2ep38CCzDSPm0eM=;
        b=fDDBWhEkP5B+/EUO8PSanRsNr/sW/Ww0QX1e/GqelScCNEZ6Ka+fzYKQjr4SC7LELJ
         /e3mDNYCI/RYKU/4gZziE1M0VwvjMnYu9xivTTgcz8DfxKFzWdMSZK6/oeoL5ZbeMSOt
         i9heBQz9j8jm2zOJL0kWRFNHzSdDmuYRALShxfOMvPBGlVOAsYnjOde9jnnnEQrkmO1H
         IJBZdTRmrnzSrIFdHwhUok7C8LlcgkRBAfnSBQBnqla+pvFRmZVaFXdlzAQ7k0KGug2U
         CpMwEqEsCGJywigJPqFy0v/Ga/CktCofRy3qfVkAuvpzV+L4qh8sxkvBu59kOCA3SnXc
         mz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632341; x=1787237141;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Or9PP7IwqRPVBd8HQX8kQHcQn2EW2ep38CCzDSPm0eM=;
        b=k+m0EEcYjx4WL6H4LxZLXZZb4eI4Ajz1DT3saNvnHmk+Bj9/85SoASs4ntuTA3IdFg
         IUD2kHpzu+0cSDvHfTGl847StbAGh+E4xePqL81nFwrK9cKeQ2pSBUgVSTIn4aaNLqKb
         N7IbXhGXzHvA0uzxIh7gCRk3NXLd5404Nj1/ZNecfXNZMmtJ0kooZ3/bPmWeqepT/tpr
         TvslDLNm5gC+gvqtyVUEKSawDQ3Mtmpoq66DBsYJQFrSlEFFVxPm+Si9teVLuhPzX/fK
         Zk9+iusYjjh+lNEgCVjBWTlT1dhKJExG/mwBb6pJsj6sRD/5g3BDiOcVqRcxUv5nwJcS
         f2uA==
X-Gm-Message-State: AOJu0Yy4mr2I02hvUOOm06Vye9yy1P2X/6AT5CxYvwQmdaBzOfQJ6Yvd
	cuur4xqMUvh71C1OIesxUPwA7xhVXmKnJzceq+ZtqoZ8ZW3vmP6t4pbu5DtBGw==
X-Gm-Gg: AR+sD10avn7ZUxJstI7Yz3nSe+f/mZBV0DlDywzo3Gna38iqUX/EaQCC90lg70c34lK
	jho6gsa/Z+klDgPRRFERHyFFE2FKdEhDjZhmzCuaBUrx9xNw8sOXvXfCkcZOQOv4tkh8bFAQsDm
	Vj/BYdaeuWghNvOctpNpnw+688wBvC4XrVPdZa4rEAU3bXCxI8nadHTootOR4w04qmUK1to4Gaw
	hRnwPnwubQX5tvIakU2iBB94xZJxpapC2myWnIklIPL+HVTswQlpxbURwfIxnevaQaQWdINPfdM
	96h/o1DzkY3JVC18jUXvGwlaP0dHMInEGElJsrW7vOZZTMhlKdiZDNA4O8UUc8hTu+m4XVAsUEF
	VeKTkmjfjvSJ1P90EJGaP5h69J0LqP1MoyZPEmFe5KrIbAYFVCIyvz0EcH+WvW2L36YSxuy5b45
	NBQdHsDI+GarAdjKY1PyEVFJY2e8pDZffhecEwbVpJtAeAB3f+aEhw5u4=
X-Received: by 2002:a17:902:ebc1:b0:2d0:3412:a3f0 with SMTP id d9443c01a7336-2d37e9bd64amr75641765ad.19.1786632341136;
        Thu, 13 Aug 2026 07:45:41 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c4caf5csm10765705ad.76.2026.08.13.07.45.38
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:45:40 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: util-linux@vger.kernel.org
Subject: [RFC] pack/unpack: generic archive creation and extraction utilities
Date: Thu, 13 Aug 2026 11:45:35 -0300
Message-ID: <20260813144535.79126-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I'd like to ask whether two small archive-oriented commands, pack and
unpack, would be considered within the scope of util-linux.

The idea is a simple interface for a common operation that currently
requires knowing the particular archive/compression tool and its syntax:

  pack FORMAT SOURCE...
  unpack ARCHIVE

For example:

  pack tar.zst src/
  pack zip file1 file2 dir/
  unpack archive.tar.zst
  unpack archive.zip

pack requires the output representation to be selected explicitly,
while unpack detects the existing representation automatically.
The intention is not to replace tar, gzip, xz, 7z, etc., nor to
expose all of their specialized functionality. It is to provide a
small generic interface for the basic "pack these files" / "give me
back these files" operations.

I first asked on the GNU coreutils list:

  https://lists.gnu.org/archive/html/coreutils/2026-08/msg00027.html

Pádraig Brady replied that the functionality is useful (he had
previously used atool for this). He was not convinced coreutils is
the right home, suggested util-linux as one possible fit (noting it
has general non-Linux-specific tools despite the name), and also
suggested investigating whether pack/unpack might belong in
libarchive alongside bsdtar.

I am writing here to ask if util-linux would consider
commands with this scope in principle.

I have a working reference implementation in C (current tip v1.6.1):

  https://github.com/IRodriguez13/pack-unpack

The implementation uses libarchive rather than implementing archive
formats itself. It currently supports tar and compressed tar variants,
zip, 7z, and several raw compression formats.

Some properties of the current code:

  - silent successful operation, with -v for member listing;
  - relative archive member names;
  - atomic archive creation using a temporary file and rename;
  - defensive extraction against absolute paths, "..", and
    symlink/hardlink escapes;
  - explicit overwrite policies;
  - conservative metadata restoration by default, with -p for
    additional metadata;
  - regression tests for malformed and hostile archives;
  - CI on GNU/Linux (glibc and musl), FreeBSD, and macOS,
    including ASan/UBSan testing.

The reference tree is GPLv3+ today. I am the copyright holder and am
willing to relicense those sources under GPL-2.0-or-later (util-linux's
default) if the concept is of interest.

I realize an optional libarchive dependency may itself be an important
consideration, so feedback on whether that would be a fundamental
obstacle would also be very welcome.

Before attempting to adapt anything to util-linux conventions or
preparing patches, I'd like to know whether commands with this scope
are something the project would consider in principle.

Feedback on the interface, scope, naming, or whether this belongs
elsewhere would be very welcome.

Thanks,

Iván Ezequiel Rodriguez
ivanrwcm25@gmail.com
https://github.com/IRodriguez13/pack-unpack
