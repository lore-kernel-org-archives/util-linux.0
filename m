Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBFF2FA0C6
	for <util-linux@vger.kernel.org>; Thu,  8 Jan 2026 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897118; cv=none; b=O29EH5kIIMbKRXyw3AjQ+I7mCF4asVJqwq8ordAMUqSa+2Hs+WdcAmdUSdvSv2UOqBE4Y7TUdx3Uu9Hm6LDEx2ZkvdgrSq7NGunM4tsLAYDVxRUA3bSCyI3T54PKAn1Jw3XKI8F13KCygk30xSyXBADimgt8lYnEHzQR38cW05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897118; c=relaxed/simple;
	bh=hb0mMDnC/p6UVx7QF1Smp54x51ep5cbvO4ykPCM1Y+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEn9n5U0batI85AcYN8PnPrpxTrjaihFpqlmlx8DkLCequYQVBBkJRFpoPK6OwFQAvCyDmre9vZCquz/kd2D9c26SFVYk1i3we8w4tOAbogMjODaWb6zS4+Wq8dQobg6GxOfilTzPPM4m2lefRMWHdriIHSC90YFb7vneauXWOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drkeaxDk; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drkeaxDk"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5634feea416so1307826e0c.2
        for <util-linux@vger.kernel.org>; Thu, 08 Jan 2026 10:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767897115; x=1768501915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UnIzZu5hArsFqqyyNxOg5iniHYJJG25rCjy6M19ImA=;
        b=drkeaxDkJC7JBclxzhcrz15O+mYTEUKgfpNs8frL7EMT6g8vex67xAnwd8hgPJumCU
         QetJ5CzXjnrAnk5eG62fRWSE4QaILh7T+o2Pa40KyQyqFHJrmxQMCMzNMhIiWhty2aIl
         bJo2+XhX7oSJbniA05amHxkzsZZ3itQNG9YwAMJnzMkzMsPD7I2KC6ff+Gwn62DlM48G
         /TEpBSc7C2FED46kpZ3CuRuxHEBzZq4++paL5tTk2ZDfBjavBv6lYpOwtun0uiQsteZN
         6cCFW1xf6K9tbS0Q9gucJ6o0mNDfWccJyxylhdyUCR6c7nM/w/XLvZTTDyhJax3gUt0r
         tdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897115; x=1768501915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UnIzZu5hArsFqqyyNxOg5iniHYJJG25rCjy6M19ImA=;
        b=Ma4BIqXjiOrzwc8UXE9/uubb8/Wz7YyhQpkI/mwffsXMqehWF86CWy1A131XQigkwQ
         3Brdtc7oCmdU2T4YBLU21Fjd66MSrZRttE6jPj7MSRNDpZcTyd1UrGQRruPUJaI6rEp1
         c9gr6211GHoBZNvooT3tHDcgjs1E3i9YhkJYlgMmxTuZsWzbHf900hTwmXUZSDYZ1Mk4
         Xzde2P6FwS5G+4086+v6XOK/w9ULzuxUQYDqs5SVTuPidjVCKDKejgifZ5LabjyAeOHd
         KSanqDIhdCO7vb3Lts5pp3Rygevvdyd7GlF7aLDRrlgwcLy8taqahsoYDJIAQhEJUUpm
         ILEA==
X-Gm-Message-State: AOJu0Yw4w6+YRziyPszOvaJ2vxPUyFc4dhssENHzERTfOIvP25tmMDp/
	Xoa1TI1XvA1kQCJTAmYqwyGpMupWnZwyO4cmUm1XuScPI5HmZ1yakMfLea5sZQ==
X-Gm-Gg: AY/fxX7HLFy7E554lfYSk2L6kOT/t8ujJTABhQ0gaNHzNvtXApk3ybZmC1tWA61mS0U
	7DmoQk7fjEUizhZHW3DWZjy+rg1/DCstFO8/tohUc7hM4PUAlyrlSBrtzB2kB6eQA/Kz5SZIIWD
	KC5TL38tne2VuUYHAcDqxAc/UK6SSWW25iBBYxtUm3yjisXnCLuRCW8LLr0Bvz/SfFgJOg1sZ2J
	v3eGW5JbPILYeqZEsGpvWtyiq5OLipi5yJmy7a5ahgnOv24by9X4DWGW1filnIRqUuFdalN3bRs
	LX3vM7ZGp5W3eZZwhOx1X5Dnu9Tx20Wpl2E1kYpUuX9jwHXKzsGPkImcODIoRW7MLMys98gO0g8
	DkpG0XtM6Y2ZYG1KB7+GO0lmGVLfxkV+BAcHA9/FyJ73sW5xnWpGuARrMI1kZdvdw/Cvl3YH9EC
	QL11P7nlaPnX/tR0c6eSmpv6atZoA=
X-Google-Smtp-Source: AGHT+IE9nhxpHKwYxzZAHEo2AIZbxOMByMnKV0RBMHYg+XUcx2+q+QDjIZynyJCCj6zH/nca8aH6Nw==
X-Received: by 2002:a05:6122:8b8d:b0:55a:ab0d:bf74 with SMTP id 71dfb90a1353d-56347fc993emr2192203e0c.13.1767897115429;
        Thu, 08 Jan 2026 10:31:55 -0800 (PST)
Received: from penguin.lxd ([155.117.189.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a1ea753sm7087287e0c.4.2026.01.08.10.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:31:55 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH 4/5] unshare: store child PID in global variable
Date: Thu,  8 Jan 2026 13:31:33 -0500
Message-ID: <20260108183134.23980-5-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108183134.23980-1-kiranrangoon0@gmail.com>
References: <20260108183134.23980-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After fork(), store the child PID in the global child_pid variable
so the signal handler can forward signals to it. Clear child_pid in
the child process to prevent recursion.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 sys-utils/unshare.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 9255ff4f8..8bc805e05 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -1149,6 +1149,7 @@ int main(int argc, char *argv[])
 		case -1:
 			err(EXIT_FAILURE, _("fork failed"));
 		case 0:	/* child */
+			child_pid = 0;  /* Clear in child process */
 			if (sigprocmask(SIG_SETMASK, &oldsigset, NULL))
 				err(EXIT_FAILURE,
 					_("sigprocmask restore failed"));
@@ -1156,6 +1157,7 @@ int main(int argc, char *argv[])
 				close(fd_bind);
 			break;
 		default: /* parent */
+			child_pid = pid;  /* Store child PID for signal handler */
 			break;
 		}
 	}
-- 
2.47.3

