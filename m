Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616819309C
	for <util-linux@vger.kernel.org>; Mon,  9 Mar 2026 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773021206; cv=pass; b=k2sPO5sxNbHXNfe/7vYEfbPG4+DfFYOQ7u961UJB/aAZbv8Js3P+P5NSptsetMuFYNaK1JvkivX3Ah+rR6BUx69kkBLgW9/qt8zwv78RWZ9X5bWoH4owV5EILzRZlKDIONW+RB+q7l9vWG8wp+uD4g89oNZZI+tcANshJxbpwwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773021206; c=relaxed/simple;
	bh=1VIJJ/7ZZzFSvn41hU7Y5UiagSSj6REnGok9Gnu44Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEBSq2WxkZB/Cxu3TIgE8Avpz3BIxaWYXc8z5LgNgSKHhG1hJ6sAKG5AvC7e860V9ez+otQmNF1pNRs2Bptor6khe1kVuc9w4UE8UTxyaj+SxTG9cwTcdpogDLvMliSvNwFWaNRxQ5roKZSiD0BHTzEIQ6oBta4ZMtHF8/bM1fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJoKbi2n; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJoKbi2n"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b7c2788dso5435938f8f.1
        for <util-linux@vger.kernel.org>; Sun, 08 Mar 2026 18:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773021203; cv=none;
        d=google.com; s=arc-20240605;
        b=PoSAfn7qDnyurZTprauz6obBRJTX49H7fGDl0WsDfhRY1B4vL1LJKGW7g6ezbnCnjr
         Siuz8KbozrAyDRzOWG8Ytc+8/Rx6+OosX2kvCz7kdCdijFGjJLult6N04jESt1qVbFVu
         pEhSbOBeliZZyXBDeKrYx4Igl8DDBsL+b5c/mlu5DW7YUKGTsWjEQ2dmOvVversJqhd2
         OeRf5RbMrdvFjKJZ4AJ2jh4yLf9mrXAeow9XDAUvqvo/JEgsVvmuIuP2OnqGjlX3yPrt
         dULc5aH6Ej98g4g7mIGzV5gGZOvxOo82y91OxaNs3COOhnVuABgRypGNzhLR4oKD4wnu
         Nhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k//mQt6+xwMfaWzxvcQEFYvYUGq4tlHT1wZGlHPYb/0=;
        fh=C+tSvUlM6Y4FPskYJgF5s1/anCD3kvSef4Eb0zW/rUM=;
        b=KKCDN0UjcDFrTm0RPzRZZ6JlWemwyBRB++GuL6NViOhkuKbOrieT98K0bA6BEH42h6
         rqdL+3VqKOAlf6WetR7GtF7wgabMFeb3lHmfj+0LDRCXypXgBJquFRugnULfkYs0ZSxe
         CWmF4VgjHlOyMdiA1c6cnxkX26DQT9DmPbG7NrG7ABYt+GSshn9rGrOcFN3qOsXwSJOS
         wUtJe0ZrWwLhuKifngm7AvmokYZ/XefTKQBAVVEjBdMO2HMV1tP5HHIZx31pSLL34Nde
         HFzpsNokOrKdKA6s1IcJ7ISE4s//XdWtkHsDUJoSuUbQSNs3q2Yjw3AX58XDgNzQ7pjw
         KgeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773021203; x=1773626003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k//mQt6+xwMfaWzxvcQEFYvYUGq4tlHT1wZGlHPYb/0=;
        b=gJoKbi2nXIX1JGwecnIJmMgJZepDjBViOqVtrGB7v+djI2oftaao6iuTd5kuWnVZsa
         DJa6ICL36saaYJJXRYffTyiaaKmOwImNLGyhX1XA3kVFB987Zl5UfDKzZ44Ta3xanQnt
         ppU5+mkioqPeZJU4/i3YHwN4+SSqEbo7L5Q5L4AEHfT+SJObMGrNJBeyOeV7/JbTkegT
         6TqnZIwDU0fEs68ED+7sj4gGMu5RGhiJ9moiV/LZ1DE/1YgHHbKRS8bp9C7d803V6XdJ
         2rNs1oyFK9XFHu0CtWSHyfM8Q0V0nV9bqbDidR9F7B4MhtjJGsq4uXenHKpNoOp9f5Ht
         3nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773021203; x=1773626003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k//mQt6+xwMfaWzxvcQEFYvYUGq4tlHT1wZGlHPYb/0=;
        b=ryvzvD2rHkoEmiBS/PYYHfEdRYz0Eiv6Oj7d0fW31pkJRddflHNIlgpGC6G44OmDbp
         L1X7J3p7fdLJcIaYd0E+8t6Ibl6l1LLGC4Wn66h00OeLjnoj+b0sfYuIRqR29Y//VA8x
         r9S2ZHwBBaJamaCEpJePptUvrCHsdWU96bJTrCdRFoy0DuIwe+GKRhrdXC8odqc2cOOc
         fu24OePU/eQhlDdL9rARUjwS4e9Qrk/PBFYIxXNAvSO5lzFgWnwL0Bsljz1PreAnnzAv
         ScOSJGKzM/cC8sCfl4Ggw/ndhCvcD28TVxe8VI0KBDtliQiTL+yzdZpnP0uKZ3Hyou6H
         Oj2Q==
X-Gm-Message-State: AOJu0YyqE8YYLrM2w2f3sno/uLRTg3yQBsafJJ29FCPz8wo+QGDqrLiF
	P6wN7OMftFsVCdP8955BZXcfMJpYeyPJxDYAa9T/leuOMlIEYAOwbOODFJDBYvaIKmu/OElWxyA
	c4/27UP10mQzLJ8Z4mG5IbhLeU5PKYkQ=
X-Gm-Gg: ATEYQzz/vsIdMfrcRlb1tDIE9kRAisSM5/as+K5xlN9HcMIyauBqihk5zBCIWKseFLD
	Sw3P6OuAY56qIZfpF1t2kHvA8XpoDaGdyzZzQbKxDh7Dj138jlFxHM7BSrRmVVZboBvLdzSdb3s
	ht/ZpWmbo7Qp4BhJlVhmY2kta/3GZcyRxQSYPeMX/X1uxqAQNVd0U4kIG3Jyp8xWGVRQNjwi/e7
	NH0Zzdqum+HOMJOh87XpW9kmSfXzhZRrmAzvBvlTF3l4UnUZlhhiBzNayViAycEubok/veqWm73
	bJrS8NeAJV1vP+lMTvTmEo+LQ4KwgaZ27PhOvMffMwAXUA3c
X-Received: by 2002:a05:6000:290f:b0:439:b715:6f49 with SMTP id
 ffacd0b85a97d-439da86fa3dmr15636200f8f.59.1773021202763; Sun, 08 Mar 2026
 18:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308112004.9206-1-bensberg@telfort.nl>
In-Reply-To: <20260308112004.9206-1-bensberg@telfort.nl>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 9 Mar 2026 09:52:46 +0800
X-Gm-Features: AaiRm52fxyYW2AbQY7r9EC011N0pV_F1PzSl6VSndxLMD7nWb4oTBxUSuVtgIkA
Message-ID: <CABAhCOSCJFMLKsN0x-sD6363cxyJaFHaJXy_Va9sP=Hn5H7wKg@mail.gmail.com>
Subject: Re: [PATCH 1/3] nsenter: (usage) correct the formatting of eight
 option arguments
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 7:20=E2=80=AFPM Benno Schulenberg <bensberg@telfort.=
nl> wrote:
>
> Angle brackets should wrap each placeholder separately: <file> and
> <nsid>.  Angle brackets should not enclose metacharacters (|) nor
> literal ones (=3D and :).
>
> (The mistaken formatting was introduced by commit f2a5997869.)
>
> CC: Xiao Liang <shaw.leon@gmail.com>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> ---
>  sys-utils/nsenter.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
> index f93e75af2..98da75511 100644
> --- a/sys-utils/nsenter.c
> +++ b/sys-utils/nsenter.c
> @@ -97,16 +97,16 @@ static void __attribute__((__noreturn__)) usage(void)
>         fputs(USAGE_OPTIONS, out);
>         fputs(_(" -a, --all                    enter all namespaces\n"), =
out);
>         fputs(_(" -t, --target <PID>           target process to get name=
spaces from\n"), out);
> -       fputs(_(" -m, --mount[=3D<file|:nsid>]   enter mount namespace\n"=
), out);
> -       fputs(_(" -u, --uts[=3D<file|:nsid>]     enter UTS namespace (hos=
tname etc)\n"), out);
> -       fputs(_(" -i, --ipc[=3D<file|:nsid>]     enter System V IPC names=
pace\n"), out);
> -       fputs(_(" -n, --net[=3D<file|:nsid>]     enter network namespace\=
n"), out);
> +       fputs(_(" -m, --mount[=3D<file>|=3D:<nsid>]  enter mount namespac=
e\n"), out);
> +       fputs(_(" -u, --uts[=3D<file>|=3D:<nsid>]  enter UTS namespace (h=
ostname etc)\n"), out);
> +       fputs(_(" -i, --ipc[=3D<file>|=3D:<nsid>]  enter System V IPC nam=
espace\n"), out);
> +       fputs(_(" -n, --net[=3D<file>|=3D:<nsid>]  enter network namespac=
e\n"), out);
>         fputs(_(" -N, --net-socket <fd>        enter socket's network nam=
espace (use with --target)\n"), out);
> -       fputs(_(" -p, --pid[=3D<file|:nsid>]     enter pid namespace\n"),=
 out);
> -       fputs(_(" -C, --cgroup[=3D<file|:nsid>]  enter cgroup namespace\n=
"), out);
> -       fputs(_(" -U, --user[=3D<file|:nsid>]    enter user namespace\n")=
, out);
> +       fputs(_(" -p, --pid[=3D<file>|=3D:<nsid>]  enter pid namespace\n"=
), out);
> +       fputs(_(" -C, --cgroup[=3D<file>|=3D:<nsid>]  enter cgroup namesp=
ace\n"), out);
> +       fputs(_(" -U, --user[=3D<file>|=3D:<nsid>] enter user namespace\n=
"), out);
>         fputs(_("     --user-parent            enter parent user namespac=
e\n"), out);
> -       fputs(_(" -T, --time[=3D<file|:nsid>]    enter time namespace\n")=
, out);
> +       fputs(_(" -T, --time[=3D<file>|=3D:<nsid>] enter time namespace\n=
"), out);
>         fputs(_(" -S, --setuid[=3D<uid>]         set uid in entered names=
pace\n"), out);
>         fputs(_(" -G, --setgid[=3D<gid>]         set gid in entered names=
pace\n"), out);
>         fputs(_("     --preserve-credentials   do not touch uids or gids\=
n"), out);
> --
> 2.53.0
>

Looks good. Thanks for the correction.
