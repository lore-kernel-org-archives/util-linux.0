Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945D92206B5
	for <util-linux@vger.kernel.org>; Tue,  8 Jul 2025 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977229; cv=none; b=FnZBCzrMCBbJcySUQFYyElxm/7BYye3nFsz28w5AuKqw+JWJ7rEgb0OGTfCvPDENC083rO6NaJWNBSDb8aW6R7rueoH7H0hmuk2zmzYFke0i0oKIK4F09PvNuB/OBQ55PaPrZ6HplRmiVm2TOadTO5nxk6OpOiqf5hFvW1RnBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977229; c=relaxed/simple;
	bh=qtEqcBR5K9QSjE4FdVB0kFr8OKxKw9X/glqqWyT/ImE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ea6gUjt+fvKePBB7Cn4B6756bV/9DU83RBEg7AN/FxxQLlndHSmi+OdsJALUeIfJoG2vZmfLzqnQVOK+XVVly72wEt+zLxZvQeSDR4fAtOLP+OchcCbm3C/EnoXTILQSa+DwVp38MnQKwnQkbFbZjoZq8rNr9n4gbaVOJQm0y1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XFI/8RJr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XFI/8RJr"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6098ef283f0so10726a12.0
        for <util-linux@vger.kernel.org>; Tue, 08 Jul 2025 05:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751977225; x=1752582025; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PAvbhby1FVFJ3jcHRl2TnMe/LbMq2aOyqqUdhDhgG8k=;
        b=XFI/8RJrPU2v++O3ML7/JEh3HGtRpvwcHHk2lfYibBju563uKijpT6wTp1KqO9EpmR
         NHYbNAxYwhEPR2dpvUqi+zu4hhgH9Br1LtM0zkHmGg0FvfOn12/QU6WFP1YTpBEKIRMI
         UjYeo+zgQrwd4GOQQgHudgGcBcZPaX7aPHOE6Wtai6H1N7Xdnytyn4f6yuua1RD0KWz4
         MKgCRC1XfURtYgTHXe/BsaTl6WXWDm2icplsFbfnFGTzFC2uRL+icpb+l2yh86oQ+VJV
         ptSIYIMhvUVBXo88JOVIlIFKXsgiGqrQ+QiuHdbjMUqFIymnyz29gnlwG7/hxalIRCvA
         byOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751977225; x=1752582025;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PAvbhby1FVFJ3jcHRl2TnMe/LbMq2aOyqqUdhDhgG8k=;
        b=AIt9nSNkWb1wxFhIcWVdjJHpubQdUlxmB5KCJ3C9RaKnWtLkXgJ9Wqyo1veOvNfL4c
         HZ2xqX314mZMteWfOl3VsLacibOU5iM/OG0gRPTO3dTt1iveW41kUhAGAP8+jRy4g7c6
         m6maEkqSCKMHjY42lgz8QouBq7M7soGI+rKpLZ+t9+ZKIRsyOcSxBlYkf3a5Pe8M8uEN
         9nmcDireRir5odmOqR32lyYaAyiyfmp2nZvLzZ1BcNLVT0W9SJ/DgAM8fA6TezZhXrI1
         F2VqtHG7bZBtQGzEhHA8c6Cc6M+tGEQI5c4McogWMInKola+17jLNa3EeKuLEI3LyL+J
         2c9Q==
X-Gm-Message-State: AOJu0Yyl8VJBSqjgE1QTIY2vpy4Qrov9G8gVgZu7XTTH1l5xr1slOwJO
	N/7ydqUHtIBDm8+N7eLuLgrMAWVTLDVPT9dM1T2XWIT4B9PSWe2vdpOFFYLKudXueGoCBK1Muoc
	wLrvvSFnqGnBzpGY4bv6XyxngxU2QH85Das8iaNub04xVKgWCItMgLYvUNOo=
X-Gm-Gg: ASbGncvoGzsAgN1D6XQHbNpjdNPS4YyyO9skRuzn+nZ+YwTDi0vEcLg81Cx+5ftPAdv
	Q2xADU77IdLdhWtHxnpehOF0eHbMf2EQVuR20SIFHXCD5SIaJTI9bPXA7mBXSwb0Tie5C3+iLul
	v7INP7TSOa/yHgTAtYKsQGVFsIsT1UcnfXLQ6yA0Ss62QcZz49SqZX90FVHT1HdysX4Q6wMX31k
	g==
X-Google-Smtp-Source: AGHT+IE/1RGbE0Y7GFBPfA1k6HJNDBuqvINAI+QpTJk8VPlD5Hqddufv6ANbHXokoOm+liLm8lgBvT7H0efCbHw8wKw=
X-Received: by 2002:aa7:d817:0:b0:609:b4b1:5152 with SMTP id
 4fb4d7f45d1cf-61051c56c9cmr43947a12.3.1751977225075; Tue, 08 Jul 2025
 05:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jesse Rosenstock <jmr@google.com>
Date: Tue, 8 Jul 2025 14:20:14 +0200
X-Gm-Features: Ac12FXy9qZUOGyoL6ax4__bhG1i1OjOomK7J80KoJ3K3nGb40xRcBMvJMoEDy38
Message-ID: <CAMZQ0rLE-6_Nowk5N+YCt35AM4L3XgvxtBQudr59Je73s2kffA@mail.gmail.com>
Subject: [PATCH] cpuset: Use stride in cpulist_create
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Format cpu lists for `taskset -c`, `lscpu`, etc. using stride.  This
usually produces shorter output.

Now:
% ./taskset -c 0-24:2,25-47:4 ./taskset -pc 0
pid 3937653's current affinity list: 0-24:2,25-45:4

Previously:
% ./taskset -c 0-23:2,24-47:4 ./taskset -pc 0
pid 3933321's current affinity list:
0,2,4,6,8,10,12,14,16,18,20,22,24,28,32,36,40,44

The ranges are constructed greedily; in general it is difficult to
construct a minimal list.
% ./taskset -c 0-63:3,0-63:4 ./taskset -pc 0
pid 3926213's current affinity list:
0,3,4-8:2,9-15:3,16-20:2,21-27:3,28-32:2,33-39:3,40-44:2,45

The patch below uses spaces because gmail hates tabs. Tabs are used in the PR.

https://github.com/util-linux/util-linux/pull/3646

Signed-off-by: Jesse Rosenstock <jmr@google.com>
---
 lib/cpuset.c                            | 75 +++++++++++++++++--------
 tests/expected/lscpu/lscpu-x86_64-64cpu |  6 +-
 tests/expected/misc/bits-list           |  2 +-
 tests/expected/misc/bits-parse-mask     |  2 +-
 tests/expected/schedutils/cpuset        |  4 +-
 5 files changed, 58 insertions(+), 31 deletions(-)

diff --git a/lib/cpuset.c b/lib/cpuset.c
index 533b8ab309b..d6469203092 100644
--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -147,43 +147,70 @@ int __cpuset_count_s(size_t setsize, const cpu_set_t *set)
 }
 #endif

+/*
+ * Finds the first CPU present after the specified index.
+ *
+ * start: starting index, inclusive.
+ * setsize: size of the set in *bytes*.
+ * set: CPU set to search.
+ *
+ * Return: the index of the first CPU present in `set`, starting at `start`.
+ * If no such CPU exists, returns the size of the set in *bits*.
+ */
+static size_t find_next_cpu(size_t start, size_t setsize, cpu_set_t *set)
+{
+       size_t nbits = cpuset_nbits(setsize);
+       for (; start < nbits; start++)
+               if (CPU_ISSET_S(start, setsize, set))
+                       return start;
+       return start;
+}
+
 /*
  * Returns human readable representation of the cpuset. The output format is
- * a list of CPUs with ranges (for example, "0,1,3-9").
+ * a list of CPUs with ranges (for example, "0,1,3-9:3").
  */
 char *cpulist_create(char *str, size_t len,
                        cpu_set_t *set, size_t setsize)
 {
-       size_t i;
        char *ptr = str;
        int entry_made = 0;
        size_t max = cpuset_nbits(setsize);
-
-       for (i = 0; i < max; i++) {
-               if (CPU_ISSET_S(i, setsize, set)) {
-                       int rlen;
-                       size_t j, run = 0;
-                       entry_made = 1;
-                       for (j = i + 1; j < max; j++) {
-                               if (CPU_ISSET_S(j, setsize, set))
-                                       run++;
-                               else
-                                       break;
+       size_t a = 0;  /* min for cpu range */
+       size_t next = 0;  /* where to start looking for next cpu */
+
+       while ((a = find_next_cpu(next, setsize, set)) < max) {
+               int rlen;
+               next = find_next_cpu(a + 1, setsize, set);
+               if (next == max) {
+                       rlen = snprintf(ptr, len, "%zu,", a);
+               } else {
+                       /* Extend range as long as we have the same stride. */
+                       size_t b = next;
+                       size_t s = b - a;
+                       while (((next = find_next_cpu(b + 1, setsize, set)) <
+                               max) && next - b == s) {
+                               b = next;
                        }
-                       if (!run)
-                               rlen = snprintf(ptr, len, "%zu,", i);
-                       else if (run == 1) {
-                               rlen = snprintf(ptr, len, "%zu,%zu,", i, i + 1);
-                               i++;
+                       if (b - a == s) {
+                               /*
+                                * Only print one CPU.  Hope the next one can
+                                * be put in the next range.
+                                */
+                               rlen = snprintf(ptr, len, "%zu,", a);
+                               next = b;
+                       } else if (s == 1) {
+                               rlen = snprintf(ptr, len, "%zu-%zu,", a, b);
                        } else {
-                               rlen = snprintf(ptr, len, "%zu-%zu,",
i, i + run);
-                               i += run;
+                               rlen = snprintf(ptr, len, "%zu-%zu:%zu,",
+                                               a, b, s);
                        }
-                       if (rlen < 0 || (size_t) rlen >= len)
-                               return NULL;
-                       ptr += rlen;
-                       len -= rlen;
                }
+               if (rlen < 0 || (size_t) rlen >= len)
+                       return NULL;
+               ptr += rlen;
+               len -= rlen;
+               entry_made = 1;
        }
        ptr -= entry_made;
        *ptr = '\0';
diff --git a/tests/expected/lscpu/lscpu-x86_64-64cpu
b/tests/expected/lscpu/lscpu-x86_64-64cpu
index b5b6c85c322..d359a6875e6 100644
--- a/tests/expected/lscpu/lscpu-x86_64-64cpu
+++ b/tests/expected/lscpu/lscpu-x86_64-64cpu
@@ -21,9 +21,9 @@ L1i cache:           1 MiB (32 instances)
 L2 cache:            8 MiB (32 instances)
 L3 cache:            72 MiB (4 instances)
 NUMA node(s):        3
-NUMA node0 CPU(s):
0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62
-NUMA node2 CPU(s):   1,5,9,13,17,21,25,29,33,37,41,45,49,53,57,61
-NUMA node3 CPU(s):   3,7,11,15,19,23,27,31,35,39,43,47,51,55,59,63
+NUMA node0 CPU(s):   0-62:2
+NUMA node2 CPU(s):   1-61:4
+NUMA node3 CPU(s):   3-63:4

 # The following is the parsable format, which can be fed to other
 # programs. Each different item in every column has an unique ID
diff --git a/tests/expected/misc/bits-list b/tests/expected/misc/bits-list
index 7511e5378ea..e6c6d142a2f 100644
--- a/tests/expected/misc/bits-list
+++ b/tests/expected/misc/bits-list
@@ -1 +1 @@
-11,22,33,44
+11-44:11
diff --git a/tests/expected/misc/bits-parse-mask
b/tests/expected/misc/bits-parse-mask
index 59dd4b4c169..37b1257b85e 100644
--- a/tests/expected/misc/bits-parse-mask
+++ b/tests/expected/misc/bits-parse-mask
@@ -1 +1 @@
-1,3,6,7,9,11,14-16,18,19,21,23-25,27
+1,3,6,7-11:2,14-16,18,19-23:2,24,25,27
diff --git a/tests/expected/schedutils/cpuset b/tests/expected/schedutils/cpuset
index 10e17606c0e..695e75dc9f6 100644
--- a/tests/expected/schedutils/cpuset
+++ b/tests/expected/schedutils/cpuset
@@ -8,7 +8,7 @@ masks:
 0x00000007      =               7 [0-2]
 0x00000008      =               8 [3]
 0x00000009      =               9 [0,3]
-0x00005555      =            5555 [0,2,4,6,8,10,12,14]
+0x00005555      =            5555 [0-14:2]
 0x00007777      =            7777 [0-2,4-6,8-10,12-14]
 strings:
 0               =               1 [0]
@@ -20,5 +20,5 @@ strings:
 0-2             =               7 [0-2]
 3               =               8 [3]
 0,3             =               9 [0,3]
-0,2,4,6,8,10,12,14 =            5555 [0,2,4,6,8,10,12,14]
+0,2,4,6,8,10,12,14 =            5555 [0-14:2]
 0-2,4-6,8-10,12-14 =            7777 [0-2,4-6,8-10,12-14]
