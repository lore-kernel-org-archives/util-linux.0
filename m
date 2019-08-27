Return-Path: <SRS0=xJlx=WX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0E3C3A5A3
	for <util-linux@archiver.kernel.org>; Tue, 27 Aug 2019 12:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56166206BA
	for <util-linux@archiver.kernel.org>; Tue, 27 Aug 2019 12:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="4PeAutW1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tUAQA/8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfH0M0L (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:26:11 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43611 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726170AbfH0M0L (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Aug 2019 08:26:11 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id F2DDC22015;
        Tue, 27 Aug 2019 08:26:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 27 Aug 2019 08:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ajO52jX4qp52J
        pjjttjYGWnphxcGg3GhS31Cj3dlkeg=; b=4PeAutW1RCqEdYhnTDEhMG6I+bPdN
        eo/4N+kHAZsBCx2hUYGtmMakboCVHQU+Ab2aPa+ca9DrLhXQlO99/J1x1CFfq9RG
        IhV5gdp2JDg0J2QoiBVSRyM3JMRQj3NJPpB6wII9MuvweX2Rhvvnd7KNM1Oumze2
        DfKPhScLTaBgCmkMfSJaTbVXMuZ2+56LbrIqBuFOvBXANgF3FiogjONfgxdVg0qC
        Vf34PXnMP6S/RkUA3ECLNjXqbPH0XHy/QLgsx/d7Z780Oh7BVg2GPI64d6gexoes
        8DlFiWlF5OVz/KGj1/1jyr/lojTS6RAP3GSqTPu3spWJGxvbPuoK9RcNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ajO52jX4qp52JpjjttjYGWnphxcGg3GhS31Cj3dlkeg=; b=tUAQA/8S
        gd3C6uCDg7V8l3XbkQ72q1Eorc5W/hWHO1by0UY7bX3j7DU0bXAVQvmv9+/IKTBx
        897gY0F634qnhjBWphogSQDiYUPi1GuAhvzAK6YvP/m/vZLfmdk6d+p2FvpK4UjD
        0GwymO1hDm6nsEIsxazcyRlsYzVQQ4Jss/fVKrs7cNTokxMYpEenR6U2RHe/ZcJ/
        PKabWgBUwVULeGCN5hXcJSDgiU08BnfLB4O9HCZWsHM3fVKkE6q5b5bRDfbZMcHk
        uAeEluxlZxKySJ8Cz38LbTN/RHwaKLl1Wn3G64asOvy++0FIkHFUIoXE0JpSgyJJ
        6ADwgukTjVyMKA==
X-ME-Sender: <xms:YiFlXV5rG6TBHfRMMbKw-5s42XyhkvKinwiOfrdxyOqj-e2j676JxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehjecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecukfhppeejjedruddurddvge
    dvrdduvdelnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmnecuvehl
    uhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:YiFlXXXPwEhZNlepZGsNqXv-ioyUhFD9BSQC1MddcTazBfz3meJp3w>
    <xmx:YiFlXZOqObANSXa4d8WEOd_tNItHy79yWvoAaCHbzty33zYkrEmlEQ>
    <xmx:YiFlXQGGFSFdWpVoWsny7hAPd-tN_LBWwtKvcicjX2cNVFXQxbXVCw>
    <xmx:YiFlXen-hQ1SjHM3MUFCBJYL-kOZAnqNp8lRJH8ogO6V1bRl--vC2Q>
Received: from NSJAIL (x4d0bf281.dyn.telefonica.de [77.11.242.129])
        by mail.messagingengine.com (Postfix) with ESMTPA id EEA73D60063;
        Tue, 27 Aug 2019 08:26:09 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 6d55659f (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 27 Aug 2019 12:26:09 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Karel Zak <kzak@redhat.com>
Subject: [PATCH] tests: use env and support both unbuffer/stdbuf
Date:   Tue, 27 Aug 2019 14:26:08 +0200
Message-Id: <219cbcaeb173a07e97dbac8e1b653904369d91e0.1566907983.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827111748.g4o375ya2shfrivs@10.255.255.10>
References: <20190827111748.g4o375ya2shfrivs@10.255.255.10>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Triggered by commit f612c4c67 (tests: fix --unbuffered mode with
ASAN, 2019-08-27), which says:

    Well, this patch sucks. It would be nice to have things in
    the way how it has been original expected by Patrick's patch,
    but ...

So this commit here effectively reverts it and instead tries to
improve the shortcomings of the original patch. First, it uses
env(1) to set ASAN_OPTIONS instead of directly adding it to the
args array to fix execution of "${args[@]}" "$@".

Second, it now supports both unbuffer(1) and stdbuf(1). The
latter uses LD_PRELOAD tricks, which doesn't play nicely with
ASAN, so it will not be used if ASAN has been requested. It's
still valuable to have support for both, as many more systems
will have stdbuf(1) from coreutils installed but not unbuffer(1)
from expect.

---

I wouldn't have minded, but as you state that your own patch
sucks I thought my initial approach might be preferable and thus
deemed it worthwhile to try and fix my original shortcomings.

 tests/functions.sh | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)


diff --git a/tests/functions.sh b/tests/functions.sh
index 67fab1d83..e71b0dfeb 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -425,9 +425,7 @@ function ts_run {
 	while true; do
 		case "$1" in
 			--unbuffered)
-				if type stdbuf >/dev/null 2>&1; then
-					UNBUFFERED=1
-				fi
+				UNBUFFERED=1
 				shift;;
 			--)
 				shift
@@ -437,34 +435,35 @@ function ts_run {
 		esac
 	done
 
+	declare -a args
+
 	#
 	# ASAN mode
 	#
 	if [ "$TS_ENABLE_ASAN" == "yes" ]; then
-		if [ -n "$UNBUFFERED" ]; then
-			ASAN_OPTIONS='detect_leaks=1' unbuffer "$@"
-		else
-			ASAN_OPTIONS='detect_leaks=1' "$@"
-		fi
+		args+=(env ASAN_OPTIONS=detect_leaks=1)
+	fi
 
 	#
-	# valgrind mode
+	# Disable buffering of stdout
 	#
-	elif [ -n "$TS_VALGRIND_CMD" ]; then
-                libtool --mode=execute \
-                $TS_VALGRIND_CMD --tool=memcheck --leak-check=full \
-                                 --leak-resolution=high --num-callers=20 \
-                                 --log-file="$TS_VGDUMP" "$@"
+	if [ -n "$UNBUFFERED" ]; then
+		if type unbuffer >/dev/null 2>&1; then
+			args+=(unbuffer)
+		elif type stdbuf >/dev/null 2>&1 && [ "$TS_ENABLE_ASAN" != "yes" ]; then
+			args+=(stdbuf --output=0)
+		fi
+	fi
+
 	#
-	# default mode
+	# valgrind mode
 	#
-	else
-		if [ -n "$UNBUFFERED" ]; then
-			unbuffer "$@"
-		else
-			"$@"
-		fi
+	if [ -n "$TS_VALGRIND_CMD" ]; then
+		args+=(libtool --mode=execute "$TS_VALGRIND_CMD" --tool=memcheck --leak-check=full)
+		args+=(--leak-resolution=high --num-callers=20 --log-file="$TS_VGDUMP")
 	fi
+
+	"${args[@]}" "$@"
 }
 
 function ts_gen_diff {
-- 
2.23.0

