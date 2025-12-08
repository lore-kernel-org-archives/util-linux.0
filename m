Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF92124C692
	for <util-linux@vger.kernel.org>; Mon,  8 Dec 2025 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765233729; cv=none; b=XgKIN24Vc/IZPr2gpPjy0PPTzz9ubumk9nkYeCL8TVHzhYC3/FoYIY8YOauE6Ncm28kL/yPahpQ8NwY6uUK3CV8a4VZz+QdU3es8FxJPKVi9y3yh7oucgycghuxwP5ymsQMf5foDaTGRj2RSBsfN0IQp8U3Q7dZzv9r06qIhikU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765233729; c=relaxed/simple;
	bh=kI2av8wvQ850iurT4+Q4+hkHMZ6O2sKdned8Cbdy1Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKw6DUuEEvEItNPk+1uGd1im+VMpJIhC1RELND8a1VcQyTduIllzVl5W8pgXLnviSN3IFvsvChdEkAGBTZmvXz4SfbQeTVW2pp2ytDJxHZr/wFw6x3Dgo2K8/Actezew7eh0O/bjW8+vY+OsjDIiQki0Uo1r3caSbZyOXEDWQ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/DfzUok; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/DfzUok"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-349b711d106so1751221a91.1
        for <util-linux@vger.kernel.org>; Mon, 08 Dec 2025 14:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765233727; x=1765838527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp6zpH/BY11ifKEbIQBhEIlIOBKrcjdRkhwJHpErA74=;
        b=K/DfzUoktQR1cnMPo06R+L5NxjVsAcTmAoveMxSA2KkjVK0xXxOgT7Yrs9X3jvK1DG
         TwHEu5OQ1CcKbddCu7+j8SBOttVkzT3YFrfBkNa4QNOkznyZRmKaIXeB4sMunKLxv678
         O1bu4/go4uINQ5l9rcgUj27DXBOIuuXd0JHcO6LQl7ai7ZUN9MwyWfW7q/a5Ni/7ysEA
         3i9nZswD6heb3Z0vU4k2nR13jAvSQKMBU1EECNRBy0XYMYHCHTvI1TFE3xtiCkB6q3rw
         Pkdy0OkxBro6W4nbOclkQyiZDiD4PrHyqUn/qkdDr4a22qLmixd6WUWvIL6aUWYENkPb
         PDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765233727; x=1765838527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xp6zpH/BY11ifKEbIQBhEIlIOBKrcjdRkhwJHpErA74=;
        b=PeBPbqLY817MlMNeI+gtlSJKoIksFDH0xNafF7iL3F+ct6mo9JFJmOmTL4d0BP7nSt
         WjawIQ2jy+XdbmOfD3oa+yEHyNyqu0mkOSUtfru18xhrBJkCpWOlApj+T6au4Aj6TMxk
         XDIU5LhhywwsiAGlm0Rn3h4cG8ag+RLw9G4zxtvpW2W8VLxrf/atZJgn96nqox5OJizH
         d0sXs9LPn2XaHNm1Q3XZrOBH2lh/wdkZmjFtbKXY9NJGUwP5HWcXHEaXAFpRCBqmJM2O
         f8Y7luL/uZAGLLvEtO31rdW66EviBEvggmvSxjGrVnf6d6yW4dGgGG7Ksn5F4iTP+wKU
         K9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAyMR1T0dWWWW0B/tO79VDyMtRkkeBsULO8j8Msnxay3jyuzqxQTsb8Tbsdacucvfh4/Dfrydp/ZgW@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVNKaMa7Ubkqp8eL3RUsV2y6CqjyTseJBJX8ixbr7A5w83BRb
	CtAAwQI9T1HwusJCpQZEK8veZikd/1eUDXr7XA4sNjn2myqlrfjsgIFs6w8i8YIVrmhLQkWy/oO
	Pi4VU8/oIP8ynKZeMYYK9c5q6j+jMYtXPaxsgkGGJqI/D
X-Gm-Gg: ASbGncu/sDuDBZyhjeKy9oQ1zfXrqaXr8EybVioQZ0XvarbxGzDeXU6+4o9rdxixFqz
	b+4qit852u9a0nU7RHuEVXWxhxhJ5/XO/1EnwEJ7sjINULj3HVJ1b2Nc/fRVPMGfLif6R3BpRSr
	RsJ7RI22NzIGJWQ8w7wPGybsIwQhqR94SLBg50BNHOQPPSPO4nd9Mxy+SvwbA8JAbuWzEZf1lg3
	/2Hly2Bj6fDB6OZ5akcwrYD3CkU5dFPZ5kSOdtvyJ2LZjilh4cJ2G8fdSdh6sDWg62VkZY=
X-Google-Smtp-Source: AGHT+IErSUwz20iny+YyAUICwal5WJMcEjn5ABXd3u/4H4bx6u6RJKjD4EZndd7vf1rf16tOmWQMRv09PomB3CAVQ3g=
X-Received: by 2002:a17:90b:2d8d:b0:340:c151:2d66 with SMTP id
 98e67ed59e1d1-349a26bb2dcmr7351319a91.30.1765233726948; Mon, 08 Dec 2025
 14:42:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601093150.16912-1-alx@kernel.org> <460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
 <mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
 <5272b875-bec8-4b28-84e8-05606db83120@linaro.org> <CAMe9rOpqX9cdhvMneHnfvJFG8ixJsdAyd6iK8mh_Th1Lpv4ahQ@mail.gmail.com>
 <lhuh5u2aat0.fsf@oldenburg.str.redhat.com> <CAMe9rOqMGabug88Qm7p22Qk+oMOk9YdbAQeyb77rL3ot4HS1UA@mail.gmail.com>
 <lhuzf7tl7fz.fsf@oldenburg.str.redhat.com> <CAMe9rOq6mx_ZQs_z2QazC2pbvJZDZzD7kLCo=_o9eTj3cUh8nA@mail.gmail.com>
 <lhuqzt5l4pk.fsf@oldenburg.str.redhat.com> <ad7ac28b-fa81-48a1-b3f5-e2ab21f83c51@linaro.org>
 <lhujyyxjbjy.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhujyyxjbjy.fsf@oldenburg.str.redhat.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Tue, 9 Dec 2025 06:41:28 +0800
X-Gm-Features: AQt7F2rw4cbBed2Z_kdayA8GAuB8VnSfczQ1llCoJrJGc8GQyzZPPFejGukVV94
Message-ID: <CAMe9rOpkDi3Pq+vexnU8aP0f1xpcHRAAiwAR9CN7Ovh=3B3m9g@mail.gmail.com>
Subject: [PATCH v3] x32: Implement prctl in assembly
To: Florian Weimer <fweimer@redhat.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, Alejandro Colomar <alx@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, 
	GNU C Library <libc-alpha@sourceware.org>
Content-Type: multipart/mixed; boundary="0000000000003da0150645788193"

--0000000000003da0150645788193
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 10:25=E2=80=AFPM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> * Adhemerval Zanella Netto:
>
> > On 08/12/25 06:09, Florian Weimer wrote:
> >> * H. J. Lu:
> >>
> >>> On Mon, Dec 8, 2025 at 4:11=E2=80=AFPM Florian Weimer <fweimer@redhat=
.com> wrote:
> >>>>
> >>>> * H. J. Lu:
> >>>>> Here is the v2 patch to implement prctl in assembly for x32.
> >>>>>
> >>>>> Since the variadic prctl function takes at most 5 integer arguments=
 which
> >>>>> are passed in the same integer registers on x32 as the function wit=
h 5
> >>>>> integer arguments, we can use assembly for prctl.  Since upper 32-b=
its in
> >>>>> the last 4 arguments of prctl must be cleared to match the x32 prct=
l
> >>>>> syscall interface where the last 4 arguments are unsigned 64 bit lo=
ngs,
> >>>>> implement prctl in assembly to clear upper 32-bits in the last 4 ar=
guments
> >>>>> and add a test to verify it.
> >>>>
> >>>> What's the advantage of the assembler implementation over the C
> >>>> implementation?  I'm missing the context for this change.
> >>>>
> >>>
> >>> It is inspired by
> >>>
> >>> commit 6a04404521ac4119ae36827eeb288ea84eee7cf6
> >>> Author: Florian Weimer <fweimer@redhat.com>
> >>> Date:   Sat Feb 17 09:17:04 2024 +0100
> >>>
> >>>     Linux: Switch back to assembly syscall wrapper for prctl (bug 297=
70)
> >>
> >> The justification for that does not apply to x32, though, because prct=
l
> >> doesn't take floating point arguments.  I don't have a strong opinion,
> >> the C and assembler versions are of similar complexity.
> >
> > The main justification is UB to va_args *all* the arguments without tak=
ing
> > in the consideration which option is passed.  If x32 requires additiona=
l
> > argument handling to clear the upper 32-bits, there is no advantage of
> > using the assembly wrapper.
>
> I'm okay with making this change to avoid UB.
>
> Patch looks okay to me.
>
> Reviewed-by: Florian Weimer <fweimer@redhat.com>
>
> Minor nit:
>
> +weak_alias (__prctl, __prctl_time64)
> +hidden_weak (__prctl_time64)
>
> This isn't necessary because there is no __prctl_time64 on x32.

Fixed in the v3 patch I am checking in.

Thanks.

--=20
H.J.

--0000000000003da0150645788193
Content-Type: application/x-patch; 
	name="v3-0001-x32-Implement-prctl-in-assembly.patch"
Content-Disposition: attachment; 
	filename="v3-0001-x32-Implement-prctl-in-assembly.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mixqjfoi0>
X-Attachment-Id: f_mixqjfoi0

RnJvbSAyNGNmNzVlOGQ3YWI3MzVmOWEwNjI4NmUyMjg0NjZjMGYzM2M3OTgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSC5KLiBMdSIgPGhqbC50b29sc0BnbWFpbC5jb20+CkRhdGU6
IFN1biwgNyBEZWMgMjAyNSAxMTozMzozMyArMDgwMApTdWJqZWN0OiBbUEFUQ0ggdjNdIHgzMjog
SW1wbGVtZW50IHByY3RsIGluIGFzc2VtYmx5CgpTaW5jZSB0aGUgdmFyaWFkaWMgcHJjdGwgZnVu
Y3Rpb24gdGFrZXMgYXQgbW9zdCA1IGludGVnZXIgYXJndW1lbnRzIHdoaWNoCmFyZSBwYXNzZWQg
aW4gdGhlIHNhbWUgaW50ZWdlciByZWdpc3RlcnMgb24geDMyIGFzIHRoZSBmdW5jdGlvbiB3aXRo
IDUKaW50ZWdlciBhcmd1bWVudHMsIHdlIGNhbiB1c2UgYXNzZW1ibHkgZm9yIHByY3RsLiAgU2lu
Y2UgdXBwZXIgMzItYml0cyBpbgp0aGUgbGFzdCA0IGFyZ3VtZW50cyBvZiBwY3J0bCBtdXN0IGJl
IGNsZWFyZWQgdG8gbWF0Y2ggdGhlIHgzMiBwcmN0bApzeXNjYWxsIGludGVyZmFjZSB3aGVyZSB0
aGUgbGFzdCA0IGFyZ3VtZW50cyBhcmUgdW5zaWduZWQgNjQgYml0IGxvbmdzLAppbXBsZW1lbnQg
cHJjdGwgaW4gYXNzZW1ibHkgdG8gY2xlYXIgdXBwZXIgMzItYml0cyBpbiB0aGUgbGFzdCA0IGFy
Z3VtZW50cwphbmQgYWRkIGEgdGVzdCB0byB2ZXJpZnkgaXQuCgpTaWduZWQtb2ZmLWJ5OiBILkou
IEx1IDxoamwudG9vbHNAZ21haWwuY29tPgpSZXZpZXdlZC1ieTogRmxvcmlhbiBXZWltZXIgPGZ3
ZWltZXJAcmVkaGF0LmNvbT4KLS0tCiBzeXNkZXBzL3VuaXgvc3lzdi9saW51eC94ODZfNjQveDMy
L01ha2VmaWxlICAgfCAgNiArKwogLi4uL2xpbnV4L3g4Nl82NC94MzIve3ByY3RsLmMgPT4gcHJj
dGwuU30gICAgIHwgMzUgKysrKystLS0tLS0KIC4uLi9zeXN2L2xpbnV4L3g4Nl82NC94MzIvdHN0
LXByY3RsLXgzMi5jICAgICB8IDYzICsrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdl
ZCwgODQgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pCiByZW5hbWUgc3lzZGVwcy91bml4
L3N5c3YvbGludXgveDg2XzY0L3gzMi97cHJjdGwuYyA9PiBwcmN0bC5TfSAoNTAlKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IHN5c2RlcHMvdW5peC9zeXN2L2xpbnV4L3g4Nl82NC94MzIvdHN0LXByY3Rs
LXgzMi5jCgpkaWZmIC0tZ2l0IGEvc3lzZGVwcy91bml4L3N5c3YvbGludXgveDg2XzY0L3gzMi9N
YWtlZmlsZSBiL3N5c2RlcHMvdW5peC9zeXN2L2xpbnV4L3g4Nl82NC94MzIvTWFrZWZpbGUKaW5k
ZXggMTZiNzY4ZDhiYS4uMDA0ZjQ0OTg4MyAxMDA2NDQKLS0tIGEvc3lzZGVwcy91bml4L3N5c3Yv
bGludXgveDg2XzY0L3gzMi9NYWtlZmlsZQorKysgYi9zeXNkZXBzL3VuaXgvc3lzdi9saW51eC94
ODZfNjQveDMyL01ha2VmaWxlCkBAIC0zLDYgKzMsMTIgQEAgZGVmYXVsdC1hYmkgOj0geDMyCiAK
IGlmZXEgKCQoc3ViZGlyKSxtaXNjKQogc3lzZGVwX3JvdXRpbmVzICs9IGFyY2hfcHJjdGwKKwor
dGVzdHMgKz0gXAorICB0c3QtcHJjdGwteDMyIFwKKyMgdGVzdHMKKworQ0ZMQUdTLXRzdC1wcmN0
bC14MzIuYyArPSAkKG5vLXN0YWNrLXByb3RlY3RvcikKIGVuZGlmCiAKIGlmZXEgKCQoc3ViZGly
KSxjb25mb3JtKQpkaWZmIC0tZ2l0IGEvc3lzZGVwcy91bml4L3N5c3YvbGludXgveDg2XzY0L3gz
Mi9wcmN0bC5jIGIvc3lzZGVwcy91bml4L3N5c3YvbGludXgveDg2XzY0L3gzMi9wcmN0bC5TCnNp
bWlsYXJpdHkgaW5kZXggNTAlCnJlbmFtZSBmcm9tIHN5c2RlcHMvdW5peC9zeXN2L2xpbnV4L3g4
Nl82NC94MzIvcHJjdGwuYwpyZW5hbWUgdG8gc3lzZGVwcy91bml4L3N5c3YvbGludXgveDg2XzY0
L3gzMi9wcmN0bC5TCmluZGV4IDcxNGZkMjg4MzcuLjgyNzEwMWU4YWEgMTAwNjQ0Ci0tLSBhL3N5
c2RlcHMvdW5peC9zeXN2L2xpbnV4L3g4Nl82NC94MzIvcHJjdGwuYworKysgYi9zeXNkZXBzL3Vu
aXgvc3lzdi9saW51eC94ODZfNjQveDMyL3ByY3RsLlMKQEAgLTEsNSArMSw1IEBACi0vKiBwcmN0
bCAtIExpbnV4IHNwZWNpZmljIHN5c2NhbGwuICB4ODYtNjQgeDMyIHZlcnNpb24uCi0gICBDb3B5
cmlnaHQgKEMpIDIwMjAtMjAyNSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4KKy8qIFRo
ZSBwcmN0bCBzeXN0ZW0gY2FsbC4gIExpbnV4L3gzMiB2ZXJzaW9uLgorICAgQ29weXJpZ2h0IChD
KSAyMDI1IEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLgogICAgVGhpcyBmaWxlIGlzIHBh
cnQgb2YgdGhlIEdOVSBDIExpYnJhcnkuCiAKICAgIFRoZSBHTlUgQyBMaWJyYXJ5IGlzIGZyZWUg
c29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcgpAQCAtMTcsMjYgKzE3LDIx
IEBACiAgICA8aHR0cHM6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+LiAgKi8KIAogI2luY2x1ZGUg
PHN5c2RlcC5oPgotI2luY2x1ZGUgPHN0ZGFyZy5oPgotI2luY2x1ZGUgPHN5cy9wcmN0bC5oPgog
Ci0vKiBVbmNvbmRpdGlvbmFsbHkgcmVhZCBhbGwgcG90ZW50aWFsIGFyZ3VtZW50cy4gIFRoaXMg
bWF5IHBhc3MKLSAgIGdhcmJhZ2UgdmFsdWVzIHRvIHRoZSBrZXJuZWwsIGJ1dCBhdm9pZHMgdGhl
IG5lZWQgZm9yIHRlYWNoaW5nCi0gICBnbGliYyB0aGUgYXJndW1lbnQgY291bnRzIG9mIGluZGl2
aWR1YWwgb3B0aW9ucyAoaW5jbHVkaW5nIG9uZXMKLSAgIHRoYXQgYXJlIGFkZGVkIHRvIHRoZSBr
ZXJuZWwgaW4gdGhlIGZ1dHVyZSkuICAqLworLyogQ2xlYXIgdXBwZXIgMzItYml0cyBpbiB0aGUg
bGFzdCA0IGFyZ3VtZW50cy4gIFNpbmNlIHRoZSBmaXJzdCBhcmd1bWVudAorICAgb2YgcHJjdGwg
aXMgaW50LCBsZWF2ZSBpdCBhbG9uZS4gICovCisjdW5kZWYJRE9fQ0FMTAorI2RlZmluZSBET19D
QUxMKHN5c2NhbGxfbmFtZSwgYXJncywgdWxvbmdfYXJnXzEsIHVsb25nX2FyZ18yKSBcCisgIG1v
dmwgJWVzaSwgJWVzaTsJCQlcCisgIG1vdmwgJWVkeCwgJWVkeDsJCQlcCisgIG1vdmwgJWVjeCwg
JXIxMGQ7CQkJXAorICBtb3ZsICVyOGQsICVyOGQ7CQkJXAorICBtb3ZsICRTWVNfaWZ5IChzeXNj
YWxsX25hbWUpLCAlZWF4OwlcCisgIHN5c2NhbGw7CiAKLWludAotX19wcmN0bCAoaW50IG9wdGlv
biwgLi4uKQotewotICB2YV9saXN0IGFyZzsKLSAgdmFfc3RhcnQgKGFyZywgb3B0aW9uKTsKLSAg
dW5zaWduZWQgbG9uZyBpbnQgYXJnMiA9IHZhX2FyZyAoYXJnLCB1bnNpZ25lZCBsb25nIGludCk7
Ci0gIHVuc2lnbmVkIGxvbmcgaW50IGFyZzMgPSB2YV9hcmcgKGFyZywgdW5zaWduZWQgbG9uZyBp
bnQpOwotICB1bnNpZ25lZCBsb25nIGludCBhcmc0ID0gdmFfYXJnIChhcmcsIHVuc2lnbmVkIGxv
bmcgaW50KTsKLSAgdW5zaWduZWQgbG9uZyBpbnQgYXJnNSA9IHZhX2FyZyAoYXJnLCB1bnNpZ25l
ZCBsb25nIGludCk7Ci0gIHZhX2VuZCAoYXJnKTsKLSAgcmV0dXJuIElOTElORV9TWVNDQUxMX0NB
TEwgKHByY3RsLCBvcHRpb24sIGFyZzIsIGFyZzMsIGFyZzQsIGFyZzUpOwotfQorUFNFVURPIChf
X3ByY3RsLCBwcmN0bCwgNSkKKwlyZXQKK1BTRVVET19FTkQgKF9fcHJjdGwpCiAKIGxpYmNfaGlk
ZGVuX2RlZiAoX19wcmN0bCkKIHdlYWtfYWxpYXMgKF9fcHJjdGwsIHByY3RsKQpkaWZmIC0tZ2l0
IGEvc3lzZGVwcy91bml4L3N5c3YvbGludXgveDg2XzY0L3gzMi90c3QtcHJjdGwteDMyLmMgYi9z
eXNkZXBzL3VuaXgvc3lzdi9saW51eC94ODZfNjQveDMyL3RzdC1wcmN0bC14MzIuYwpuZXcgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwLi4yOTViMDllMzY0Ci0tLSAvZGV2L251bGwK
KysrIGIvc3lzZGVwcy91bml4L3N5c3YvbGludXgveDg2XzY0L3gzMi90c3QtcHJjdGwteDMyLmMK
QEAgLTAsMCArMSw2MyBAQAorLyogU21va2UgdGVzdCBmb3IgcHJjdGwuCisgICBDb3B5cmlnaHQg
KEMpIDIwMjEtMjAyNSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4KKyAgIFRoaXMgZmls
ZSBpcyBwYXJ0IG9mIHRoZSBHTlUgQyBMaWJyYXJ5LgorCisgICBUaGUgR05VIEMgTGlicmFyeSBp
cyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IKKyAgIG1vZGlm
eSBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBMZXNzZXIgR2VuZXJhbCBQdWJsaWMKKyAg
IExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVp
dGhlcgorICAgdmVyc2lvbiAyLjEgb2YgdGhlIExpY2Vuc2UsIG9yIChhdCB5b3VyIG9wdGlvbikg
YW55IGxhdGVyIHZlcnNpb24uCisKKyAgIFRoZSBHTlUgQyBMaWJyYXJ5IGlzIGRpc3RyaWJ1dGVk
IGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgICBidXQgV0lUSE9VVCBBTlkg
V0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICAgTUVSQ0hB
TlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZSBH
TlUKKyAgIExlc3NlciBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisK
KyAgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBMZXNzZXIgR2Vu
ZXJhbCBQdWJsaWMKKyAgIExpY2Vuc2UgYWxvbmcgd2l0aCB0aGUgR05VIEMgTGlicmFyeTsgaWYg
bm90LCBzZWUKKyAgIDxodHRwczovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uICAqLworCisjaW5j
bHVkZSA8c3RkaW50Lmg+CisjaW5jbHVkZSA8c3lzL3ByY3RsLmg+CisjaW5jbHVkZSA8c3VwcG9y
dC9jaGVjay5oPgorCisvKiBPbiB4MzIsIHdoZW4gcGFyYW1ldGVycyBhcmUgcGFzc2VkIGluIDY0
LWJpdCByZWdpc3RlcnMsIG9ubHkgdGhlIGxvd2VyCisgICAzMiBiaXRzIGFyZSB1c2VkIGFuZCB0
aGUgdXBwZXIgMzIgYml0cyBtdXN0IGJlIGNsZWFyZWQuICAqLwordHlwZWRlZiB1bmlvbgorewor
ICBzdHJ1Y3QKKyAgICB7CisgICAgICB1bmlvbgorCXsKKwkgIGNvbnN0IGNoYXIgKnB0cjsKKwkg
IGludCBpMTsKKwl9OworICAgICAgaW50IGkyOworICAgIH0gczsKKyAgbG9uZyBsb25nIGxsOwor
fSBwYXJhbWV0ZXJfdDsKKworc3RhdGljIGludAorX19hdHRyaWJ1dGVfXyAoKG5vaXBhKSkKK2Rv
X3ByY3RsIChpbnQgb3AsIGxvbmcgbG9uZyBhcmcxLCBsb25nIGxvbmcgYXJnMiwgbG9uZyBsb25n
IGFyZzMsCisJICBsb25nIGxvbmcgYXJnNCkKK3sKKyAgcmV0dXJuIHByY3RsIChvcCwgYXJnMSwg
YXJnMiwgYXJnMywgYXJnNCk7Cit9CisKK3N0YXRpYyBpbnQKK2RvX3Rlc3QgKHZvaWQpCit7Cisg
IHBhcmFtZXRlcl90IG5hbWUgPSB7IHsgeyAidGhyZWFkIG5hbWUiIH0sIC0xIH0gfTsKKyAgcGFy
YW1ldGVyX3QgemVybyA9IHsgeyB7IDAgfSwgLTIgfSB9OworICBURVNUX0NPTVBBUkUgKGRvX3By
Y3RsIChQUl9TRVRfTkFNRSwgbmFtZS5sbCwgemVyby5sbCwgemVyby5sbCwKKwkJCSAgemVyby5s
bCksIDApOworICBjaGFyIGJ1ZmZlclsxNl0gPSB7IDAsIH07CisgIG5hbWUucy5wdHIgPSBidWZm
ZXI7CisgIFRFU1RfQ09NUEFSRSAoZG9fcHJjdGwgKFBSX0dFVF9OQU1FLCBuYW1lLmxsLCB6ZXJv
LmxsLCB6ZXJvLmxsLAorCQkJICB6ZXJvLmxsKSwgMCk7CisgIGNoYXIgZXhwZWN0ZWRbMTZdID0g
InRocmVhZCBuYW1lIjsKKyAgVEVTVF9DT01QQVJFX0JMT0IgKGJ1ZmZlciwgc2l6ZW9mIChidWZm
ZXIpLCBleHBlY3RlZCwgc2l6ZW9mIChleHBlY3RlZCkpOworICByZXR1cm4gMDsKK30KKworI2lu
Y2x1ZGUgPHN1cHBvcnQvdGVzdC1kcml2ZXIuYz4KLS0gCjIuNTIuMAoK
--0000000000003da0150645788193--
