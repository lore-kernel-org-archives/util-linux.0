Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35083451BA
	for <util-linux@vger.kernel.org>; Fri, 16 Jan 2026 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583226; cv=none; b=GhV5P3h2vCgP0hRyY27Wg1rFGbKKpJJ27hWDwITqo0HD4VGEMPTmG3YcMEN5xb+cJD0ITdI7zdBYhlX6rDkHJXpyNduO9Smi9knxMrHpINE/f1WEK7OXfMwdQBDGhVP1Ql8xCfrDaAHhpxxnBeLyOcMuNvpU42r68ouTM9v77Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583226; c=relaxed/simple;
	bh=DO83z9QVV9h6e5HgvXDclz4d6T303rsMWujqsEdonOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbzVFIdzCj5EpQSzFK0y2B/1TG2AGh++P01MrJn6C7LGkMuY47sL6dDii9DHtkLky/FfRUitHG6BVIPcsMg7LkyWL5F+5RU1wyeRwTV1x0SXePZYxRebkXHAs4w+J0ueKJJjN4JX6Nftco1Xdn9P4ciEAQ+7Pf1eJGOeLePjC7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXbEW2A8; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXbEW2A8"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-42fed090e5fso1249075f8f.1
        for <util-linux@vger.kernel.org>; Fri, 16 Jan 2026 09:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768583223; x=1769188023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCE+J655Es9BsEuqoFwElhpzsgap6tBBM1jOH1FW8cc=;
        b=WXbEW2A8sX5JRy0KY36PnKkSCB99Uf/4eWeU3SPCCtgdGOKCbyzBPVYXyISmOKzMA+
         gNfzJY+TezmVGZdwdZSk1a0JPjp4uI1JQqDHOxM6yhHW9gNGH9tSG5D1QEXgAksKVTz+
         uabU2n+hPy+WwWC7oA+aa17pU0EvlCySmKkUWf9BiVK4UGYNsuA4dZDVaGhKgQBtFuwR
         ++E3suzAcM0gLEWV9mMiJhyN2Ton0O00KnEf3AqhtCR9c/8R/juZ6Bkzgk4NBRycKPxR
         9G9b/cngStCRS4RP2nkcVSd2olfT7Df2cdfyYU8ZEUniBUo+PcTGtUvOdPHm7l71jNVz
         WxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768583223; x=1769188023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zCE+J655Es9BsEuqoFwElhpzsgap6tBBM1jOH1FW8cc=;
        b=vk9RW5dXMR6Hzp+rQE9R5rvU4HVd0MGeq0+c0yDkvSxWEY45WmTMGq1Fx57W5hIGQK
         1leEHQNHEWRltsFxYsnnuAqLxv+ofCwmrcZMgjOcItnAryjL46rLgg3haYU1phCtDcPz
         uDqwbQ40TcPr04tcdGK9gNl0ynMzNfOyBeY31P6q1DiFSryPO042wHrPaKOrfLVZfc/e
         tzb5YkCUOsZjUkawPEiaSv168YxIGkmQXWKNrnTa1hr7n9i7Ue8Jb0ufIhpve0SJEmzE
         tMK9FROYuR5Q7seiHvAqJvxoNxhKh8G3cljgafXWWDNHjHvkiu5ctiFlwJ/pnjJJjOLD
         W04g==
X-Gm-Message-State: AOJu0YxpIxNFqmH+IH9BctHmSOhye7zQmgYY+ZY5nAOt1/1t8+gVrm1M
	HOLcdEvKWZBpyvXBzukgDe9OYip9NCVu/s6zzYhwU5hEs3vq3T9T+fOeJnhE2eJen/OSfA==
X-Gm-Gg: AY/fxX6nmTzipG9Ne1LOyierI9GROkh1z05qQHih7QfW8eU4Rk6ezEbLSW76LZE306k
	NByURECcADOMVu42R5r+TfxZVIVuEhukvE+lDDSmRoylQykcghZpqe7EZ5sOJjwhKVdz7MAOsBi
	tM4tF9sxqyTWTc+M0h8zmlufaYaLAETg1/VKX8O6TvA7jKtttBvJFUzrKYc+uV3wARgWpCAsty4
	QJtOloCZztjEpJzpihZ4G7HjziQKrEjAzn8DulSwFeFg114Dlu7Ca8LA8+YVnTgaOu+4/eZGW8Q
	WTLqJsezNbRSAg/5BZ/ki/gK0WX0yyDJj04zbYOwsh3gDfnd6IlFzR1tg2A/4m8+IBcrVsnqw25
	1VsHLjrJ/vII12Kgs3BYK3BBRbnElmo2J6yjNhIq8f+uEhwykkMaFJp1NVS1P73fEAz8T1fAjmD
	0dtqNe0mkSD2f2wH9YakDR9gV0qAI=
X-Received: by 2002:a05:6000:26d2:b0:432:c0e6:cfc7 with SMTP id ffacd0b85a97d-43569979c68mr3896913f8f.8.1768583222533;
        Fri, 16 Jan 2026 09:07:02 -0800 (PST)
Received: from penguin.lxd ([149.102.244.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699982aasm6526709f8f.42.2026.01.16.09.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 09:07:02 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [Patch V3 3/4] unshare: document --forward-signals in man page
Date: Fri, 16 Jan 2026 12:06:47 -0500
Message-ID: <20260116170648.26439-4-kiranrangoon0@gmail.com>
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

Add documentation for the new --forward-signals option, explaining
its use case (graceful shutdown during reboot/system management)
and interaction with the --fork option.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 sys-utils/unshare.1.adoc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sys-utils/unshare.1.adoc b/sys-utils/unshare.1.adoc
index 1d1fd68f8..888928147 100644
--- a/sys-utils/unshare.1.adoc
+++ b/sys-utils/unshare.1.adoc
@@ -81,6 +81,19 @@ Create a new time namespace. If _file_ is specified, then the namespace is made
 *-f*, *--fork*::
 Fork the specified _program_ as a child process of *unshare* rather than running it directly. This is useful when creating a new PID namespace. Note that when *unshare* is waiting for the child process, then it ignores *SIGINT* and *SIGTERM* and does not forward any signals to the child. It is necessary to send signals to the child process.
 
+*--forward-signals*::
+Forward *SIGTERM* and *SIGINT* signals received by the parent *unshare* process to the child process.
+When this option is not specified, *unshare* ignores these signals while waiting for the child process
+to exit (the default behavior since util-linux 2.36). This allows the parent to remain alive while
+the child process handles the signals.
++
+This option is useful when the parent *unshare* process will receive *SIGTERM* or *SIGINT* signals
+(for example, during system reboot or from a process manager), and you want the child process to
+be notified of graceful shutdown requests so it can perform cleanup operations. If your child
+process has signal handlers (such as shell trap handlers), enabling this option allows them to execute.
++
+This option implies *--fork*.
+
 *--keep-caps*::
 When the *--user* option is given, ensure that capabilities granted in the user namespace are preserved in the child process.
 
-- 
2.47.3

