Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29EC2D46B1
	for <util-linux@vger.kernel.org>; Wed,  2 Jul 2025 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751486918; cv=none; b=nQnikUH+IpozX3a0K3GB37I0V0jfV68oS59gcb33aVl0a+gVJlKKhUXf0sXdD1pK9NVgMHDWAkqplcIm+TfK6lmNx4kcPJow9+kGt4+Oz/TRwCFojb7NI9yN9HcjhligiowdIKGEgK1/Qm4v5C6jIdNINFO5Pn8vzpVTlLwnvYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751486918; c=relaxed/simple;
	bh=QjhzAzeV3H1d4jskjvPvEXxhzOPsq/MbxkQEfMKI9AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YK9FcOdsBcJbap7Zhv/7ss5QsLd7o+zsXsKrayvokhDSEctSZ55kJY9iSVo6OSvKsgbFpcKfjAsMcafDfh6ycp3Mk8yIJ7GNlgKE56ukfrOW1O/NOPxemub8tA+3CDdvt9m5YRzsZFEwxcdMNrIXAovrIHlT394pflRjAS/8KzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9ORGQgT; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9ORGQgT"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so575a12.1
        for <util-linux@vger.kernel.org>; Wed, 02 Jul 2025 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751486915; x=1752091715; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9aYKeGozxVCYl/HOEIZSLuVpbeVap5Mgslfq/TEjGPA=;
        b=O9ORGQgT8fK5PELpYejnNDHmzk24emP8XL9Zr/z8iHUc8PNITUrLJkJp6oPcpXb4Da
         5VsPT/o01X9WYkKmXllkepW1YkSzypruABXoLhznCoKw4lGqJ2J0u6I5aqM1+WKvweWp
         u9q3rt3GB+PRMGTBm0q5Dyi1+qfhQtgdVM2LeYr7/BOCPwK+ZPScxbQ6ccNArL/9icqI
         4BwbJjAw50/Wl93MWxMAMrspmEN2XBq6wec/5z1DumfTtKEoEJ285KwdWWUNbqM9N9fg
         BR1Fdlsg3f8Wh8P/zN9XoimTM66PODk8rB0p3WTXJg2NDfA1E5SWZxzEzoBZn/e8RJGx
         vYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751486915; x=1752091715;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aYKeGozxVCYl/HOEIZSLuVpbeVap5Mgslfq/TEjGPA=;
        b=RS3wfEwyxkqOOry6QsPjsC6pHOmNJu6xZbmVs9e8FwrVjGDq2PWBLwBNJNzSgbdhpN
         rstOYbzLlc2mTvG6cBwf2+tF+3bBasPomsQEpR//I+Ys9GyJVysmwOBUez4v/90vQ4U6
         qz5gGUOQ4Dy0+QMhHtycN/VUmRBkp1brtkLUJfd8kJOnvNQ12AQbmNOEL3zLUNoJICqg
         Ph13bIdSqNVsgr6LWZH0+q5QXFMonmCPxrfC2iSIDY8aIDacpnboKQqbQ6IhxSl+LDFo
         pfNhIYI3x1Vt14MPgizHJsyouzV3KRBnwT0oUV8Qhb23GVZE9/ZBioxnBEI09d/YFgH3
         Djng==
X-Gm-Message-State: AOJu0YzHC9u6kuDpEKuuKoiyz1d00f82gW2ZJGMI3Xomc2jS8w5kG7PP
	AxTXkbrqSSUoA81CNXz7lDCNfmhqCcY/vohow1Aod84KOU0qz9A+aTEty7NJVAenFlNHyVht29z
	nmEUrHLmEHeED6uy+0jGjIpEnKztKW0PKF+fyt0oRmInGR9C8M/R4ns3D3XM=
X-Gm-Gg: ASbGnct7vE+mvApbl/fzh2v38/krOMg4Cs7HHkIDRl2PFZArNtj9JyhLhgmcNCaJcRX
	Ebi8o+VZMU0YmQgiaoRx7A1F/IVchhks7QdKbeTqepqh3WKInjPklUDWuIDjl4h1Z5ScgZe52Rg
	pbTj7gkqngtJ3WxI2S5isBs/9QHXb/VkIbVNlw5az6FqLYrS0pasI5b20agdtGl4o0aCVS4C2z
X-Google-Smtp-Source: AGHT+IHhCxlKHrz9x3QlWlEnxojgPShFPclPyuZi4S6oXzSh96PyTrjw2swZpAUVwqAXj2ajSRvh07VoFxbDbdzmO+0=
X-Received: by 2002:a05:6402:2284:b0:60e:2e88:13b4 with SMTP id
 4fb4d7f45d1cf-60e71613632mr9148a12.3.1751486914551; Wed, 02 Jul 2025 13:08:34
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMZQ0rLM9UYMupEX4WLmi-J9mh0jGhruzDw3OwpU8yEf0+2E_Q@mail.gmail.com>
 <lscxfxbzi6j667md5buwprb5muuzpmsdpvvpmbdk7jvsq2rtxo@ucpthvyj2efw>
In-Reply-To: <lscxfxbzi6j667md5buwprb5muuzpmsdpvvpmbdk7jvsq2rtxo@ucpthvyj2efw>
From: Jesse Rosenstock <jmr@google.com>
Date: Wed, 2 Jul 2025 22:08:23 +0200
X-Gm-Features: Ac12FXxTJ90-7mBX5VQ5JBLluB1a_gWVId_f5B597VkoMXqwhVjF5t1_pKGu_s8
Message-ID: <CAMZQ0r+-JSaC7UFvAvG10cvqSKiQY--7VYtpsEALidF44wmjbg@mail.gmail.com>
Subject: [PATCH v3] taskset: Accept 0 pid for current process
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Diffs from v2:
  * Use strtos32_or_err to parse pid

https://github.com/util-linux/util-linux/pull/3637

This is useful to print the current mask without using `$$`: `taskset -p 0`.

It is also helpful to test taskset: `taskset -c 1-4 taskset -p 0`.
This is not easy with `$$`.

sched_setaffinity(2)/sched_getaffinity(2) accept 0 for the calling
thread, so this seems consistent.

As an implementation detail, we replace 0 with getpid(), so the existing
pid != 0 <==> "will exec" logic continues to work unchanged.

A reasonable alternative would be to interpret just `taskset` (currently
an error) as printing the current mask.  This seems less orthogonal,
and a better use may be found for plain `taskset` in the future.

Signed-off-by: Jesse Rosenstock <jmr@google.com>
---
 schedutils/taskset.1.adoc |  8 ++++++++
 schedutils/taskset.c      | 13 ++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/schedutils/taskset.1.adoc b/schedutils/taskset.1.adoc
index 9384347372..45622613bd 100644
--- a/schedutils/taskset.1.adoc
+++ b/schedutils/taskset.1.adoc
@@ -77,6 +77,7 @@

 *-p*, *--pid*::
 Operate on an existing PID and do not launch a new task.
+If PID is zero, then operate on the *taskset* process.

 include::man-common/help-version.adoc[]

@@ -134,6 +135,13 @@
 $ echo $? +
 1 +

+== EXAMPLES
+
+Print the current CPU affinity as a list.
+
+$ taskset -pc 0 +
+pid 1355988's current affinity list: 0-47 +
+
 == AUTHORS

 Written by Robert M. Love.
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index b52cd4338b..7e2ecc3365 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -186,7 +186,18 @@
                        all_tasks = 1;
                        break;
                case 'p':
-                       pid = strtopid_or_err(argv[argc - 1],
_("invalid PID argument"));
+                       /*
+                        * strtopid_or_err() is not suitable here; 0 can be
+                        * passed.
+                        */
+                       pid = strtos32_or_err(argv[argc - 1],
+                                             _("invalid PID argument"));
+                       if (pid == 0)
+                               pid = getpid();
+                       /*
+                        * After this point, pid == 0 means "no pid" and that
+                        * we will exec a command.
+                        */
                        break;
                case 'c':
                        ts.use_list = 1;
