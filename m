Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbd2w2X8"
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9305FA3
	for <util-linux@vger.kernel.org>; Wed,  6 Dec 2023 16:42:11 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1fb9a22b4a7so256485fac.3
        for <util-linux@vger.kernel.org>; Wed, 06 Dec 2023 16:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701909729; x=1702514529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s48vyisboB8ghP7lfEJD4GH9tIgP+HZzBOQSJ+QpMjE=;
        b=cbd2w2X8fJombC4ycolqB0GC2ClWF/Q4h+0l1N91XKZd/sxJUDYREDuo5i8a51cear
         kudfH2v/YHXm+LS5sMpgCQasvbsgvxmolrKZmc6HV3lLmjQSQVOnmBYD3Rd1m0uthvoa
         25F4z7sTw0v7/bsYfEHfGpbLLDXJTlOexG8uJ6McrViaDPP6r7IHNOOeVRL3CbeYA6aJ
         oma3uMnIrRngxfDDclusptsLDcxvILlnP9y2jKiq0ahtoyYhEGTBOCrOyN1L5/mC35fY
         RVpLf3ZYxAv5CSmdRcRjyYdLkGU17pHHLjqEewPwciZDaCM9wyv01OBnGuYT5ziG73C0
         ek4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701909729; x=1702514529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s48vyisboB8ghP7lfEJD4GH9tIgP+HZzBOQSJ+QpMjE=;
        b=SX+w9dS43mUk0CERBLe8AoAsFo7tZoq6FTlim6qvyuZ611101JZ9/qhIYKap26GVR5
         pt8WpIaIyRacGSU49D6TOhXzfyhgU210d4cuSSXuPH41v38+L8QiSZVY6TTxaaswFIMp
         2XaNBHbL/oabbxEriK+GMqj7fcO4wL10nUOtUkYzIURrFXCMJ7oWAG1kKkuQ+Vn8cfeV
         MLX9XbncRAr/QA9zLjePrB6zUHb4ioxQl/NyDZ3/k881da/3H6xVE0NH30SoPmdikNB3
         DGD79YbULIvy/03T9qi6+WksPyikv1tb5Zfsb8ZU0XShXPMH1n/ycTNWiMv42oALKr/g
         ZaKA==
X-Gm-Message-State: AOJu0Yz2t/3WsF+JZ/WU7jLAtF5PRJLQuVpqemSr33m81Sm6uzJs2MFm
	LIgeJYOH20tUZiCijjHKl9CzQ9XLwPY=
X-Google-Smtp-Source: AGHT+IEfUTaCOANSIkrOKpBqdJQ6mxdTCaVnJYvsnRJQIq9Z1RG0MAMGvpODU/u58+J8HC/SLuHiQw==
X-Received: by 2002:a05:6870:818d:b0:1fb:75b:99b0 with SMTP id k13-20020a056870818d00b001fb075b99b0mr1914176oae.95.1701909729102;
        Wed, 06 Dec 2023 16:42:09 -0800 (PST)
Received: from acleverhostname.attlocal.net (108-200-163-197.lightspeed.bcvloh.sbcglobal.net. [108.200.163.197])
        by smtp.gmail.com with ESMTPSA id gy26-20020a056870289a00b001fb05cf9dfdsm33638oab.19.2023.12.06.16.42.08
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:42:08 -0800 (PST)
From: Eli Schwartz <eschwartz93@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] bash-completion: make sure that "lastb" actually completes
Date: Wed,  6 Dec 2023 19:40:44 -0500
Message-ID: <20231207004204.3443364-1-eschwartz93@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building util-linux logs a warning on Gentoo:

```
 * Problems with installed bash completions were found:
 *
 * 	lastb: incorrect name, no completions for 'lastb' command defined.
 *
 * For more details on installing bash-completions, please see:
 * https://wiki.gentoo.org/wiki/Bash/Installing_completion_files
```

A bash-completion file is usually composed of two parts:
- a function that knows how to produce completions
- a specification of which command should be completed

In cases where multiple commands have the same options, e.g. commands
that are symlinked to each other, it is common to symlink the completion
files as well. This shares the first part. But the second part cannot be
shared, it must be implemented twice by specifying two different
commands to be completed.

"lastb" had a symlinked completion, but when the completion system
processes /usr/share/bash-completion/completions/lastb, it would only
define a completion for "last".

Define both completions in one file, so that sourcing it works
regardless of command used.
---
 bash-completion/last | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bash-completion/last b/bash-completion/last
index 180d9a94b..ff264c1d2 100644
--- a/bash-completion/last
+++ b/bash-completion/last
@@ -51,4 +51,4 @@ _last_module()
 	COMPREPLY=( $(compgen -u -- $cur) )
 	return 0
 }
-complete -F _last_module last
+complete -F _last_module last lastb
-- 
2.41.0

