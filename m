Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F203352929
	for <util-linux@vger.kernel.org>; Tue, 13 Jan 2026 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325400; cv=none; b=szYyh9wf7Cded7qqRqrnosKxKOnAT3Il5PjYOAoAj/uHnIC2ua66WGqSaiAbULqZ2V8dIFqDsTMlyE+D+4JjY2mvULOIvzY3d9i8kl4Az2BpJhzNOPkaGOvabGn9XHJZdD31JUuugr+6W+rrr+a3ReiIo00tmVWDqIvdXNwS2tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325400; c=relaxed/simple;
	bh=FW5Yp3rTV4JuHqKe4DEZipMlPaZ39n2tfBtxw/LAuKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTpNyeO217w32aYsE5MoNHlHPWzawTQBeMcESeSvY7HkBPyn1rj1zKuIxJQftg64VLSyhIYBOMmH6Y/DV6e9CPd8szqjGHmqRVTVNIaRcMtjbnyXIvvi1dMYksILuTEPCii4NQ5ebSd3KDXbW7JAFjqd9QF5r4lxYAaaN+U8ALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9FcPsg+; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9FcPsg+"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so13448777a12.3
        for <util-linux@vger.kernel.org>; Tue, 13 Jan 2026 09:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768325397; x=1768930197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbvZcXZWIvjjAqMeIQ/8dKvynJZdwh7/JPfsLlg4bIo=;
        b=l9FcPsg+RFC51XYCK0yX6mhXgUegAbkGf+eqmzyKxqvAHK4xl+xKR8FVnIhJ5zaWFK
         YbmT2ARBeKTz+S/rsHsTwDEs0cADyrXjIlL8m04O7e9AHNgzbvlKnna9BBI5ZitIP6Il
         O+SxZaTUmhql0LUIbIpahuWt+w0DTot/k6gBWtgL+api5YO2DpVZgDKXBGp5fzNNGsN2
         XeWkjdBaO5MHrroY+BioyfvXUjlbk2HBAU/l7M5e4V+KhGcdR0w8bRwech+oJDEVP4Sv
         FNIHka/T/bKZhMQ3+w7yfpueJJiaOKCYYTJwv3jOq6W1Wy1YN4F4bKiE6Xg155NHY7To
         gB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325397; x=1768930197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mbvZcXZWIvjjAqMeIQ/8dKvynJZdwh7/JPfsLlg4bIo=;
        b=m1M+tf+PFsLC8WbBeff8VXgaerYmc61nMFzZflXtq4sEP5LaC8Y9cbuU27znfMfB6B
         TwitSkm0s95bm6tKTcq7Ttl8X8Wtr8LfVuKUSzAUKbIfGhR4kMiMApkzS58lBcAB+lOY
         BnzpWJflPud7Ff0o5ys/S8mWVpYQnMR4m7soI8U47oWHkG7ew9b6Q3kcrFHwABHWGS7E
         rPoDbyxIPCfxC4V3ddtZ7zKXgxPy0Alxlamc1A6vIa0pKMuDkqyHZ/XOIO6LhQgswT8h
         BrEfahcmULD1D/qiIggeDzOSnWLJNkFyZudXTXY/Amams4hIbL0ieCIHR7nuBBxzcIGn
         agTw==
X-Gm-Message-State: AOJu0YwIqc32TXxtchp3gfJWSMkq5lmuqD41pIUgk1txlS4NPYtl9+Su
	LZdl2XryMcF71WTA8m3dYHBsSavqJGMd+3QhksyOc/nTI6X/cCttEshxtLw6/uqJHL0=
X-Gm-Gg: AY/fxX7MsXA6dzjGhyVICA4ctwf6UlqUZbINQC+7lqKUHqzU9njprZKihhHDgLPcIFY
	7R1gstBH3j2Jvx3+/gtA6UvcRbpYNZZBFdaJoMs3zI2aS6Xa7cHtV2NA7azxLhvAAcN9ZLnqlOJ
	OrNxa+VGaegqe//wFYYVNVBOsrcCcJIU2gmmbKpRSzF98udABo3LSXUQF/7xFmef/ZPG+QsylPW
	P6+4u5arMbRr8e8zBTFlVB1XscaFNCT6HK6My7FllnIKla070sytkkVjpJRAdnodBVDOuBVvRnI
	KDrTftUYeRlBwBAcodQSoXCWEef9vdKR+ktqehAIQHqFRa934Qw8+Drgrtug8VXFuEZw34TDUtQ
	UC1sr8XuDKRHZfduHGJ2hlHpvOxX5FX66wGw2lfqkTjSG76JU5DxcLxZ5A0BVzDGywpxahIJUJT
	yZDQYANEVuRsvlReFua0YYOqGa
X-Google-Smtp-Source: AGHT+IHOO41dOSSU8Zg5Hg1/xRCqjN2ee33PcQ+AhEJsbWz/tiATXPGF2ENIKeuHSu+IZSqEmx94cA==
X-Received: by 2002:a05:6402:40ca:b0:64d:41af:2e8f with SMTP id 4fb4d7f45d1cf-65097e5ea6fmr18995342a12.23.1768325397325;
        Tue, 13 Jan 2026 09:29:57 -0800 (PST)
Received: from penguin.lxd ([149.88.27.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4484sm20835469a12.7.2026.01.13.09.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:29:57 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [V2 1/4] unshare: add --forward-signals option to argument parser
Date: Tue, 13 Jan 2026 12:29:39 -0500
Message-ID: <20260113172942.10678-2-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113172942.10678-1-kiranrangoon0@gmail.com>
References: <3tysdpabjulwlmr3hkm4pr7romwtf6cofhghth7buyuxnmwr5r@pliehv2xicmy>
 <20260113172942.10678-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new --forward-signals command-line option that will allow
unshare to forward SIGTERM and SIGINT signals from the parent
process to the forked child process.

This commit adds the option parsing infrastructure but does not
implement the signal forwarding logic yet. The flag defaults to 0
(disabled) to maintain backward compatibility.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 sys-utils/unshare.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 5370ab981..7e94b9148 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -801,6 +801,7 @@ int main(int argc, char *argv[])
 		OPT_MAPAUTO,
 		OPT_MAPSUBIDS,
 		OPT_OWNER,
+		OPT_FORWARD_SIGNALS,
 	};
 	static const struct option longopts[] = {
 		{ "help",          no_argument,       NULL, 'h'             },
@@ -817,6 +818,7 @@ int main(int argc, char *argv[])
 
 		{ "fork",          no_argument,       NULL, 'f'             },
 		{ "kill-child",    optional_argument, NULL, OPT_KILLCHILD   },
+		{ "forward-signals", no_argument,     NULL, OPT_FORWARD_SIGNALS },
 		{ "mount-proc",    optional_argument, NULL, OPT_MOUNTPROC   },
 		{ "mount-binfmt",  optional_argument, NULL, OPT_MOUNTBINFMT },
 		{ "map-user",      required_argument, NULL, OPT_MAPUSER     },
@@ -843,7 +845,7 @@ int main(int argc, char *argv[])
 
 	int setgrpcmd = SETGROUPS_NONE;
 	int unshare_flags = 0;
-	int c, forkit = 0;
+	int c, forkit = 0, forward_signals = 0;
 	uid_t mapuser = -1, owneruser = -1;
 	gid_t mapgroup = -1, ownergroup = -1;
 	struct map_range *usermap = NULL;
@@ -1015,6 +1017,10 @@ int main(int argc, char *argv[])
 			keepcaps = 1;
 			cap_last_cap(); /* Force last cap to be cached before we fork. */
 			break;
+		case OPT_FORWARD_SIGNALS:
+			forkit = 1;
+			forward_signals = 1;
+			break;
 		case 'S':
 			uid = strtoul_or_err(optarg, _("failed to parse uid"));
 			force_uid = 1;
-- 
2.47.3

