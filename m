Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118158;
	b=hOIpMFFZRciFUw2Uh4SzGvtFJuBCriNSIl5QZO5+jkSogWlR0yw75haN8CeXh940lUW4
	 nvIGTCYgwRvcfGkzuZBqrR4KERM+vHDc55/HyC+eocSqk2IFevQUyDxPpDY72SNjePiKv
	 9hlEfU9Mcvg5t01DUhmAnOYVjh/cDv0ll4nPVjvdsKOFymr+S3S9q6lx5ndGq1MlIsN8i
	 5QYGbHqwQjvOcZInETm30wrXHP2CisOuEB3yTLmc96Cj4yezNff5r+7vnjXaLK87yqvXg
	 FrUoY6YjUgG8LHukcO9B5kMFbJztMOv55H6JxMbN6F7jReTtWSdG/PQ6ky0vl5K96iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118158;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BWGkbn9c7cFX+ovbl04OLKBF5w/QAe/48HtdDnWfsro=;
	b=W3nIkNO+VXvagvJ9B+P1a/tr0GF9+raUTtEL+5jLY+Rrvj6oPqD0ATjA4NPbV98cMfYe
	 R2ATJkhp31gi3lF0/yl8gePzKiPAPbK0sLDjGiM+8Y2WJ1Sa3dgPfrY/mqGwlSUW+uhfS
	 +AuG1xmeQ1bP3hHmDh3Pm454hBG5OSl2CAlXo/0ob2pG3ORwljPDombAxLI6Kx1UtdMIS
	 oXclD9L7a8B/LP9i6fqSSbL+va9TmWfJAD63rAElhWow6JHq68iyqRgnhAdoKFeA/4TEG
	 9EmfROuQ8NDGrsH8RhpQFMzYuH21cJ3D/mogczqCOk4InBqcF18EUd1v65Id11fT6xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WHMCnGdE;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FB1606A334
	for <util-linux@vger.kernel.org>; Tue, 27 Oct 2026 16:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14FB1606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WHMCnGdE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A65A15A1;
	Tue, 27 Oct 2026 09:22:33 -0700 (PDT)
Received: from u200865.usa.arm.com (U203867.austin.arm.com [10.118.30.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 152753F59E;
	Tue, 27 Oct 2026 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793118156; bh=wkEjAsZt6Q9TfkokeG8Ik9lpFpbB0WSvdSJFuc7yank=;
	h=From:To:Cc:Subject:Date:From;
	b=WHMCnGdEpWa6cKg5MX7ox8i8SJsM2dRvEzoxjcRAP+a1Nv2m2oDCzhWd4AQXYlyFp
	 +SSqq1aD1j5hs808veuGeFSqtrbFaQ+e+GydQKlXaFW1+zjjglKFuXirYIbtvpvPov
	 1o0wU260FVW2wu4wLmLbwZdZS4f8UEFWPqht9POw=
From: Jeremy Linton <jeremy.linton@arm.com>
To: util-linux@vger.kernel.org
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Jonathan Thackray <jonathan.thackray@arm.com>
Subject: [PATCH] lscpu: New Arm C2-Ultra, fix ordering
Date: Tue, 27 Oct 2026 11:22:30 -0500
Message-ID: <20261027162230.175940-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Post: <mailto:util-linux@vger.kernel.org>
List-Help: <mailto:util-linux+help@vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:util-linux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm has announced the C2-Ultra with a TRM here:
https://support.arm.com/documentation/109736/latest/

Also, put a couple out of order parts, in ascending order.

Cc: Jonathan Thackray <jonathan.thackray@arm.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 sys-utils/lscpu-arm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 84b5d1665..0e19db505 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -52,8 +52,8 @@ static const struct id_part arm_part[] = {
     { 0xc08, "Cortex-A8" },
     { 0xc09, "Cortex-A9" },
     { 0xc0d, "Cortex-A17" },	/* Originally A12 */
-    { 0xc0f, "Cortex-A15" },
     { 0xc0e, "Cortex-A17" },
+    { 0xc0f, "Cortex-A15" },
     { 0xc14, "Cortex-R4" },
     { 0xc15, "Cortex-R5" },
     { 0xc17, "Cortex-R7" },
@@ -84,9 +84,9 @@ static const struct id_part arm_part[] = {
     { 0xd16, "Cortex-R52+" },
     { 0xd20, "Cortex-M23" },
     { 0xd21, "Cortex-M33" },
-    { 0xd24, "Cortex-M52" },
     { 0xd22, "Cortex-M55" },
     { 0xd23, "Cortex-M85" },
+    { 0xd24, "Cortex-M52" },
     { 0xd40, "Neoverse-V1" },
     { 0xd41, "Cortex-A78" },
     { 0xd42, "Cortex-A78AE" },
@@ -117,6 +117,7 @@ static const struct id_part arm_part[] = {
     { 0xd8e, "Neoverse-N3" },
     { 0xd8f, "Cortex-A320" },
     { 0xd90, "C1-Premium" },
+    { 0xd96, "C2-Ultra" },
     { -1, "unknown" },
 };
 
-- 
2.56.0

