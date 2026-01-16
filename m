Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1DB368282
	for <util-linux@vger.kernel.org>; Fri, 16 Jan 2026 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583220; cv=none; b=CJP7NIlE0DNlXy+EuDG21vNw2YOKrxuqBHcNYdSJUYW/JemZgBCcEKRex/ZHw/GhpZb7l9slVets8Hmtm+pCMysf/a9gsKX6UF8vgvZjCSiMHs9k1+34rXjw+jYQdKNI/BrRju7yfE3NdJKRqM1tDdq79LFc9CGTInRpmo1C4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583220; c=relaxed/simple;
	bh=4uPz4C/SnvdWyWxH7SbKMsubv8I6CCaKNebnOjCJDJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzeEwVw5b2jwWjmZFnVOpKA/5P6ebcAAGGHOoMp9wPu3JdKIkvd7whk9APuLaPh+Y2moOrrzkYtj2AugbTN7qVV9PqaWDfXQytEMhvQgjqWd+VMmbjyEIfzmBnIk6oeeBm23wd7QrqzU4z5776qoMw1gbuxYsGLS08YMb3hxcEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5P/4DHG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5P/4DHG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edffe5540so22213785e9.0
        for <util-linux@vger.kernel.org>; Fri, 16 Jan 2026 09:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768583217; x=1769188017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH4eIaKBuDTeloMMXCOIyFO4hA76EDMxidWyZ9HEmaA=;
        b=l5P/4DHGxw7o3PqMWWF7/TKq4qvhNE7eQINAM+Uuqlwr0DOXsJVTDgtNpFgOcCOkO0
         QDT/ApfMZGw4l0pPEFYcgo7m5h5nhkbjZDCBoIMVFI8kJKH7vqa5+keCoH14GzYHDB9E
         0MtOk/3TjMn53Y4Uv1cTh5SoJflFUC3/K4Idj7WrEYE7ud5Ae7ubgC0tFUKYzcSZfw99
         gdkq7bN20erNuJAHHLK4OrZVFFvDGeoJf+dnqDUyH/dsv/nZkgQemnGEYGsxBK+KAqp4
         kDKV/agBuHYZnIjyB7FvWa/veAlQmd8mwLbe1PJwTnIcvh+mWi0QjJK/gqhuIQMK+Tid
         q0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768583217; x=1769188017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TH4eIaKBuDTeloMMXCOIyFO4hA76EDMxidWyZ9HEmaA=;
        b=udqKcP1YWinoUojEe3vWcwhm6NTbEN/cxtVqQoAS0m+uP2hFfHegFByUhsh4eRLV7Z
         dbieDq8jZ1QBR9Ihh0LsXWPgN6pPKsFV+lIuDIPUbxRGPxV8b4ltHoVcuf5elcAS2lQW
         KuFxQgkGIoNPT38cH8M6SNgk209P+a4oLk5pZpmkviqSy9N5eUnpg3cS7QZHLQh07EEN
         Aizd/4BdLzXBCCE1wW9V8SdD32CVlpkR3zLG6XKUzJfuh0dwgUVb3IBr83+R0H3RYLeZ
         iDUw0Rtlvwx0EkSN29N4Yu8JUD6t2oLMhDazaJ1nLt6BKSf81u8fXoiyYUQOfHEioMbJ
         Tx4w==
X-Gm-Message-State: AOJu0YzC7j4ZiZ0e6pBE1D5bIpEyQDBqkmMuOhmZf0oWNGdHU8xqvPvg
	EDilpQzeNJek5A4NsoKMelgFJKT3oIjSNA4S0O0YxdTDbB5ZdSplzb1WG6TsPD2X+bI=
X-Gm-Gg: AY/fxX4LD1E4P8M1OP258zJ7a2dzxieTBqn2GkWf2XNFDh6s9b0QISCUBM9ACI3YA6L
	jGm78aDVAwcpYyy5S2aPNJ3pqMmcX27l1XhHqdadlILBK4oTjbzLxFtBzoqMV3dqr39ltzA/Tx0
	0E12so+eVGZAjfpq2JDdjN2TUhJACOrT0ULf9c7XDwrRFZmQSWNG/0liZEWnSsWr0U5fmQad7wT
	Ubxf3ShXZM3mR9u3+bpVxIzeWfx2J3zql/tKGAJW8r0SsmLkUrLyCvoGHFOFlEw+VEDzbK0QPgv
	2OqCMwn6eC2XiSbOVk4JRqnVVAEaCwdlO62s+UmEwCBLGIFJUcpOP4Lz+WJihMQDVUde8dhR68i
	CInzzD5OALDNuzow1aRHKi5U14rpKcoySxL9FZDuWf6DgYuj1GFq6PYoDLItBGAIDVTZWMQhrQX
	tTgdIY0wOGz54nIbGN
X-Received: by 2002:a05:600c:4e50:b0:47e:e952:86cf with SMTP id 5b1f17b1804b1-4801e3502bamr41889715e9.34.1768583217312;
        Fri, 16 Jan 2026 09:06:57 -0800 (PST)
Received: from penguin.lxd ([149.102.244.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699982aasm6526709f8f.42.2026.01.16.09.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 09:06:57 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [Patch V3 1/4] unshare: add --forward-signals option to argument parser
Date: Fri, 16 Jan 2026 12:06:45 -0500
Message-ID: <20260116170648.26439-2-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116170648.26439-1-kiranrangoon0@gmail.com>
References: <20260113172942.10678-5-kiranrangoon0@gmail.com>
 <20260116170648.26439-1-kiranrangoon0@gmail.com>
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
 bash-completion/unshare | 1 +
 sys-utils/unshare.c     | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/bash-completion/unshare b/bash-completion/unshare
index 19eeb8f08..fdd40e5cb 100644
--- a/bash-completion/unshare
+++ b/bash-completion/unshare
@@ -28,6 +28,7 @@ _unshare_module()
 				--cgroup
 				--time
 				--fork
+				--forward-signals
 				--kill-child
 				--keep-caps
 				--mount-proc
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 5370ab981..8a7a26df2 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -769,6 +769,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -f, --fork                fork before launching <program>\n"), out);
 	fputs(_(" --kill-child[=<signame>]  when dying, kill the forked child (implies --fork)\n"
 		"                             defaults to SIGKILL\n"), out);
+	fputs(_(" --forward-signals         forward SIGTERM and SIGINT to child (implies --fork)\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_(" --setgroups allow|deny    control the setgroups syscall in user namespaces\n"), out);
 	fputs(_(" --keep-caps               retain capabilities granted in user namespaces\n"), out);
@@ -801,6 +802,7 @@ int main(int argc, char *argv[])
 		OPT_MAPAUTO,
 		OPT_MAPSUBIDS,
 		OPT_OWNER,
+		OPT_FORWARD_SIGNALS,
 	};
 	static const struct option longopts[] = {
 		{ "help",          no_argument,       NULL, 'h'             },
@@ -817,6 +819,7 @@ int main(int argc, char *argv[])
 
 		{ "fork",          no_argument,       NULL, 'f'             },
 		{ "kill-child",    optional_argument, NULL, OPT_KILLCHILD   },
+		{ "forward-signals", no_argument,     NULL, OPT_FORWARD_SIGNALS },
 		{ "mount-proc",    optional_argument, NULL, OPT_MOUNTPROC   },
 		{ "mount-binfmt",  optional_argument, NULL, OPT_MOUNTBINFMT },
 		{ "map-user",      required_argument, NULL, OPT_MAPUSER     },
@@ -843,7 +846,7 @@ int main(int argc, char *argv[])
 
 	int setgrpcmd = SETGROUPS_NONE;
 	int unshare_flags = 0;
-	int c, forkit = 0;
+	int c, forkit = 0, forward_signals = 0;
 	uid_t mapuser = -1, owneruser = -1;
 	gid_t mapgroup = -1, ownergroup = -1;
 	struct map_range *usermap = NULL;
@@ -1015,6 +1018,10 @@ int main(int argc, char *argv[])
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

