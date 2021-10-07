Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65400C433EF
	for <util-linux@archiver.kernel.org>; Thu,  7 Oct 2021 09:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44AD761139
	for <util-linux@archiver.kernel.org>; Thu,  7 Oct 2021 09:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhJGJqb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 7 Oct 2021 05:46:31 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36927 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235101AbhJGJqb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 7 Oct 2021 05:46:31 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5BF0B5C0150
        for <util-linux@vger.kernel.org>; Thu,  7 Oct 2021 05:44:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 07 Oct 2021 05:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        from:to:subject:date:message-id:mime-version:content-type; s=
        fm1; bh=NxZbuJ6ZPNrmnwnhJS9tHFlu3YyvWb3MUppCdHzTzW4=; b=BUsBCS/1
        CbN3yDiovdLmpHI6J7Shke1cUWLtPlLHtaJlPLtyJGiJT6CiBHo3MJtYjcNJPsTV
        3w47pR99h9+xk+vtcWw9fewbL/uHB6NlfcTv2HArGsM002KVEB+JCtCVjBlLpuVi
        Uhy+T+CjOrigwiPQY+4zOrAnxL0nkJJKiXeP+gzc+hW9DnxKjp19gaw77qswonW3
        AsKwbg7GSsIxfSq6zlg7BK8mcPIRVvxDZkGV9wydt1SujSzxmRLbb+13m80Wo0Y8
        xHUHPunjByuiJVyaFpmooyv73nPvy4vqtysGEuQiyjsluHMcI5ERDgwVWs+lw8i+
        8sCFEXNoyzVCqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=NxZbuJ6ZPNrmnwnhJS9tHFlu3YyvW
        b3MUppCdHzTzW4=; b=gJ2AIIMCdheamfBGq3PMv62x8iSe2mGrJfhz+rNUL0XY9
        vkzuAUSoH1aBmgpURCpG3ah7f4bqnTscPNDty+TJQPLUcOaCUQcXlcnLTmdhPg1F
        eGE3pJDnuZXZ8awuqZMVmo3jMgEhyqAB0RGNLxeYQPw2b4xFJtDYTh1GUrIsTZU0
        Jvko0pjmDohD1zOkKRMOAaH5xEsKn3eQ9FYyMhP1SadnqVfBnxdFIqYXTe8FCalm
        LmBmPnOeAvP7NLjDnAqmc5gGAe8c8s9GnmHI1wSrsrzTfm9eJJW6SV6xHLCOQQle
        aTwU40xDJkV0ldzkLNALd55x6zPXYAFfZhhRc664g==
X-ME-Sender: <xms:hMFeYSZPxY5qf-hF9uXnSK_qRLYkwejCeFAojy0XOtAGHcQJSAZVMg>
    <xme:hMFeYVbzHEJU4cqqYN0VWyvFhusK_zyzgjaEJaUK2ulcC8Jg0clLOYXtcP9KSmml9
    UlylrIwAeJBzLd0HA>
X-ME-Received: <xmr:hMFeYc83mwcLV0YihvB_jbU-pKYYeZbDHnE0tMNH0cVUt7QMr2S8oC6Ea6Yub0Oa5hB-DgTG1S_9xaNG6u1S9BHn_5_MEQkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudelkedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkgggtsehgtderredttd
    dtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeen
    ucggtffrrghtthgvrhhnpedtkeevtdeitddvteevgfffteeufeelvdehhffghefhheeiff
    ekheeuieetjeffffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:hMFeYUop8uoy3ZZwHkulVbKa9OBOGOnJB5rSwsrJdQR2U1gpyLVXfw>
    <xmx:hMFeYdrUrxJWhEU7dzwtvRpBKuobYS3IT72f7w8sIfd0FbBiRu3BhA>
    <xmx:hMFeYSQZ-LPWHQCdDjzP-6H-X30QWC6Hsn_Pyss9DGqx6HF3TedX0A>
    <xmx:hcFeYfH6D4Zh1zR5y3IttGkYsQFzwr5LSzx1Ph9fTj4mK0xUZMjgNw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <util-linux@vger.kernel.org>; Thu, 7 Oct 2021 05:44:36 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 85316FA8; Thu,  7 Oct 2021 09:44:34 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     util-linux@vger.kernel.org
Subject: Enabling single programs after --disable-all-programs
Date:   Thu, 07 Oct 2021 09:44:24 +0000
Message-ID: <87zgrl6ufb.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi, I was hoping to be able to have util-linux's build system only build
specific programs I'm interested in.  In some cases, there are options
to do this, e.g. I could do --disable-all-programs --enable-lslogins and
get a util-linux build that's just what I need for lslogins, but for
some programs, e.g. lsblk, there's no --enable-lsblk option.

From=20what I can tell from the git history, --enable-$prog options have
generally been added a few at a time to allow specific programs to be
_disabled_, and that it's possible to build _only_ those programs using
=2D-disable-all-programs seems to mostly be a side effect.

So, would you accept a patch that added --enable-$prog options to _all_
programs (or patches that added those options one at a time whenever a
use case appeared)?

Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmFewXoACgkQ+dvtSFmy
ccAL5hAAg3tPvLqIEJJHVKIMdCa4LGKTkX/BCBvNrhce2XjuJqlgEtEIdQC9JfXU
+d53A4VPjSz9XTOkACCSuBgevV/ZWHZZtWMdenm23SGJ8luMDsYjCu/sKijjkRBt
UaKuKBwIAbBXHJUFWqAP7hRirs7gTQwUN/QhasLOzJIgF/fq3hKzyV88n6w1yCrp
mqoojK8p45T420sHFH5ujKWYZaKzVO5foP8AMeqH/PcCxoTPhhc/cV9N7h12/20v
hdkoPy/cDwELv5iS6faP+wZmNu/PV0W19mObJYBPL3EXwBfoD/7T/d0gupfJURdm
QaHF8Lrit5G/rR2FRc6UQyFq5kzSBf4VQQj+E//PS650VBky3g2eD/8NjDRG4eJq
P3+olnyP6BZABk5THdtmoIehNz5lNIdWRe/7p40Uxi0mtPuOZ1qG//g7B8zPq/E+
ymEWMQ8mSre0bw5Fk6/oq6sSfwrhN9N95DmEx4p5UlGbaQBAR+3lQDQtFw88cF4o
B14lPQPhi1T2ASUGu03zWpHJBFTN/lHOIJg08a5mlHqZ5agUKpsOPtYnZq1n5UsO
+J3WOAN3zeUU9svsUVmMixDOcoq0gok5kMbtgnkxfH7Q1w6dSt2fv/6JODUbtZuO
aPzT+aPb/umdThkvymxe37rM3a2RiiaOznQbFoZPgj4HoDeEemQ=
=wSdJ
-----END PGP SIGNATURE-----
--=-=-=--
