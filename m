Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF3AC433EF
	for <util-linux@archiver.kernel.org>; Thu,  9 Sep 2021 18:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E70610C9
	for <util-linux@archiver.kernel.org>; Thu,  9 Sep 2021 18:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbhIISIG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhIISIG (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Sep 2021 14:08:06 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC45C061574
        for <util-linux@vger.kernel.org>; Thu,  9 Sep 2021 11:06:56 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id f24so1468051uav.8
        for <util-linux@vger.kernel.org>; Thu, 09 Sep 2021 11:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=wrDV+Uv/33lVC+BepJ2Trv1YrDDtLdfDQAUh9Vl1zss=;
        b=fdd4+1vI2gESN8iHvNiPFBIEibpaTWb7nD29FDDyb++U0BwB6xoaYzL9HhaTn7bVZU
         vYR4onepCUbSA7K1JW24JIYbphw5Vuie2rth+kksejwwGwD20gq4wZnKTp3MRqWRxg8k
         yUdXol9K/iRGA3rCpgDfxK0uCszXpy4LGN6DQvwimEFZJaOifvavFYEZUDtRUmgvmbRO
         iG4aSFYDVZFMe/5O/Fx+3ZwCxLXFw+1cX/MkWnCacwo+zcvNvDAW74279Tcj2y9Llkkk
         qLl2FDL3LZWZNpz0VS8Hv1f06LIqVN3vJBh2ICClCkHLptOFiSANZg1BXx9xokU9iwup
         lxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wrDV+Uv/33lVC+BepJ2Trv1YrDDtLdfDQAUh9Vl1zss=;
        b=hXG08omvqhR8LsVx3jgd85eisMSLowkSHBveQ3RMwcG0fRPzjEnXWRJahN3aCEuwDf
         9O8DBtrjnAF2hViil/1P/dpyOO4Vwkvu2xVp6vK1l4W9KeOgMdeNN4zJwtZqQ1dRKUEy
         /pJJoVxjbiYFih4PYEzIlSZyNuTOG2ovfV/niY0cb9qxuekMAs+ooTNz36ti4nWSb4+V
         29rs4tMbIhpcGZBDgPt2TlfwAsAb6Em7cPFT9Mjeb6y96hIOF4g34EEAhXyYHk4IPIIO
         a8Enp9Ipn2zzKgykD/dSSfeD0XAhbUTb7sLwG88HbJon8OUAFenFV/KSKnd7v3VqQIjL
         9Q2A==
X-Gm-Message-State: AOAM532QpYbvOu9JESgd4Rn086yneIhIsfHFcxuhR3/9C/gaWjmRA0R9
        sCPPcZOMwlN8SKuDKd1CUZ4GhmycvD2rMVBZgmXWPhEXZe8=
X-Google-Smtp-Source: ABdhPJxXBVVEw4ah+tx6PFqMxPyx2K9lwZmMNnlZJrs9v8gys5tWUP0llPekOzwuackJ3roZJqhz9c2tb3ZPD7bAqb8=
X-Received: by 2002:ab0:5fc7:: with SMTP id g7mr2835304uaj.85.1631210815539;
 Thu, 09 Sep 2021 11:06:55 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Thu, 9 Sep 2021 20:06:44 +0200
Message-ID: <CAHi0vA_sSHZ8MV8PExEUkOuE1EhGWZ5RL_1-tLpwrbsqqMgVgw@mail.gmail.com>
Subject: PATCH: misformatting in mount.8.adoc
To:     util-linux@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000036eacb05cb93dd0c"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

--00000000000036eacb05cb93dd0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

while translating the latest changes in man pages, I found some issues
in mount.8.adoc. See the attached diff.

Unfortunately we can't use non-standard citation characters in the
Asciidoc files, like =E2=80=9Cthese=E2=80=9D. No problem so far for Asciido=
ctor
itself, but Po4a produces nonsense (unprintable) characters.

Best Regards
Mario

--00000000000036eacb05cb93dd0c
Content-Type: text/x-patch; charset="UTF-8"; name="mount.8.adoc.diff"
Content-Disposition: attachment; filename="mount.8.adoc.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ktd8qj1t0>
X-Attachment-Id: f_ktd8qj1t0

ZGlmZiAtLWdpdCBhL3N5cy11dGlscy9tb3VudC44LmFkb2MgYi9zeXMtdXRpbHMvbW91bnQuOC5h
ZG9jCmluZGV4IGZmZjZjN2MyZi4uMjIyOWUwOGRlIDEwMDY0NAotLS0gYS9zeXMtdXRpbHMvbW91
bnQuOC5hZG9jCisrKyBiL3N5cy11dGlscy9tb3VudC44LmFkb2MKQEAgLTEwNDUsNyArMTA0NSw3
IEBAIENhbiBiZSB1c2VkIHRvIHJlcGxhY2UgVVVJRCBvZiB0aGUgdW5kZXJseWluZyBmaWxlc3lz
dGVtIGluIGZpbGUgaGFuZGxlcyB3aXRoIG51CiBXaGVuIHRoZSB1bmRlcmx5aW5nIGZpbGVzeXN0
ZW1zIHN1cHBvcnRzIE5GUyBleHBvcnQgYW5kIHRoZSAibmZzX2V4cG9ydCIKIGZlYXR1cmUgaXMg
ZW5hYmxlZCwgYW4gb3ZlcmxheSBmaWxlc3lzdGVtIG1heSBiZSBleHBvcnRlZCB0byBORlMuCiAr
Ci1XaXRoIHRoZSDigJxuZnNfZXhwb3J04oCdIGZlYXR1cmUsIG9uIGNvcHlfdXAgb2YgYW55IGxv
d2VyIG9iamVjdCwgYW4gaW5kZXggZW50cnkKK1dpdGggdGhlICJuZnNfZXhwb3J0IiBmZWF0dXJl
LCBvbiBjb3B5X3VwIG9mIGFueSBsb3dlciBvYmplY3QsIGFuIGluZGV4IGVudHJ5CiBpcyBjcmVh
dGVkIHVuZGVyIHRoZSBpbmRleCBkaXJlY3RvcnkuIFRoZSBpbmRleCBlbnRyeSBuYW1lIGlzIHRo
ZSBoZXhhZGVjaW1hbAogcmVwcmVzZW50YXRpb24gb2YgdGhlIGNvcHkgdXAgb3JpZ2luIGZpbGUg
aGFuZGxlLiBGb3IgYSBub24tZGlyZWN0b3J5IG9iamVjdCwKIHRoZSBpbmRleCBlbnRyeSBpcyBh
IGhhcmQgbGluayB0byB0aGUgdXBwZXIgaW5vZGUuIEZvciBhIGRpcmVjdG9yeSBvYmplY3QsIHRo
ZQpAQCAtMTA3MSw3ICsxMDcxLDcgQEAgVGhpcyBlbmNvZGluZyBmb3JtYXQgaXMgaWRlbnRpY2Fs
IHRvIHRoZSBlbmNvZGluZyBmb3JtYXQgZmlsZSBoYW5kbGVzIHRoYXQgYXJlIHMKICogRmluZCB1
bmRlcmx5aW5nIGxheWVyIGJ5IFVVSUQgYW5kIHBhdGggdHlwZSBpbmZvcm1hdGlvbi4KICogRGVj
b2RlIHRoZSB1bmRlcmx5aW5nIGZpbGVzeXN0ZW0gZmlsZSBoYW5kbGUgdG8gdW5kZXJseWluZyBk
ZW50cnkuCiAqIEZvciBhIGxvd2VyIGZpbGUgaGFuZGxlLCBsb29rdXAgdGhlIGhhbmRsZSBpbiBp
bmRleCBkaXJlY3RvcnkgYnkgbmFtZS4KLSogSWYgYSB3aGl0ZW91dCBpcyBmb3VuZCBpbiBpbmRl
eCwgcmV0dXJuIEVTVEFMRS4gVGhpcyByZXByZXNlbnRzIGFuIG92ZXJsYXkgb2JqZWN0IHRoYXQg
d2FzIGRlbGV0ZWQgYWZ0ZXIgaXRzIGZpbGUgaGFuZGxlIHdhcyBlbmNvZGVkLgorKiBJZiBhIHdo
aXRlb3V0IGlzIGZvdW5kIGluIGluZGV4LCByZXR1cm4gKipFU1RBTEUqKi4gVGhpcyByZXByZXNl
bnRzIGFuIG92ZXJsYXkgb2JqZWN0IHRoYXQgd2FzIGRlbGV0ZWQgYWZ0ZXIgaXRzIGZpbGUgaGFu
ZGxlIHdhcyBlbmNvZGVkLgogKiBGb3IgYSBub24tZGlyZWN0b3J5LCBpbnN0YW50aWF0ZSBhIGRp
c2Nvbm5lY3RlZCBvdmVybGF5IGRlbnRyeSBmcm9tIHRoZSBkZWNvZGVkIHVuZGVybHlpbmcgZGVu
dHJ5LCB0aGUgcGF0aCB0eXBlIGFuZCBpbmRleCBpbm9kZSwgaWYgZm91bmQuCiAqIEZvciBhIGRp
cmVjdG9yeSwgdXNlIHRoZSBjb25uZWN0ZWQgdW5kZXJseWluZyBkZWNvZGVkIGRlbnRyeSwgcGF0
aCB0eXBlIGFuZCBpbmRleCwgdG8gbG9va3VwIGEgY29ubmVjdGVkIG92ZXJsYXkgZGVudHJ5Lgog
Cg==
--00000000000036eacb05cb93dd0c--
