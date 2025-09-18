Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57EB1E32D6
	for <util-linux@vger.kernel.org>; Thu, 18 Sep 2025 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185926; cv=none; b=d2yw5B8NkxA/QFtUVYHEOTe4UqFc3Fg0AEJMc+HOikaJq6jkUi3JB7EsXK+y8rLySbMl59mFokJQ4Z3Cl4j22cl+FPlyG9UuheBsvanJzLlzEKeeXyp94cJVDlZptPSNEGCm8joTDZpVCIeFW6F732uWx5gln716XEJvXTdEnjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185926; c=relaxed/simple;
	bh=+qJ8SqbqgyVnDaIWBBBAFIXUc/Z6XxneutWF09Gq8pE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9Py0T59+4NcpFGqjeQ+oetkI5exJB7u73mdWc15lJ+FJPVAoZE6Q7KFJxgwWqgoaVBliHVJo6Cp5ssSwhbdZNFG+SJ5Xc07Fr1TD2zEWKyTy4ept4HI5OnGOvvKifqHNyL/0QUZG5OHXRuOCF25jPG0BQNkeGr8kWel4r2f7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=FQPTUMAd; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="FQPTUMAd"
X-KPN-MessageId: e5e33102-946d-11f0-aad5-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e5e33102-946d-11f0-aad5-005056ab378f;
	Thu, 18 Sep 2025 11:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=0yhv9Tyas/P3iY8rSs3LH2Pfc3TAYlOZ9MZkFz8G9ZQ=;
	b=FQPTUMAdiu5SB2jgwNi+2kLSqGsB5TLHtUSEJR0pEM6TwTtixDLwCfrezGRA9PN2R49SqLbAl7UtQ
	 iVy1itQs3dW0cC4/mOfiZyXvxaQsmDSTkxLwA8d3l4MygoV9oNoPE+4gL5IBkLxgLEGr7RfaJHrv+f
	 Wg9GgEX8NIR/X9IA=
X-KPN-MID: 33|c4VRH+9Qk4P+DP8BYEluTY0WicGPjyIl/irWdy9wmSmDEyKiqBIICYOjPHdy+Gs
 PkCqwIn/px8cAah23GwGoSiGAUAxPNaadLpGJaRlXnVg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|NnyRH1MMf+y+C2gEJIN13OxxhwRmRShTOeYTeyIm0AQcLHNJlVh9xWT6UtA5Qk4
 V8P8bOD3gAIJVY/K/7d35pg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 8547eaa0-946d-11f0-a7a5-005056ab1411;
	Thu, 18 Sep 2025 10:57:35 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/6] fallocate: redo four tweaks that were accidentally undone
Date: Thu, 18 Sep 2025 10:57:05 +0200
Message-ID: <20250918085707.41785-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918085707.41785-1-bensberg@telfort.nl>
References: <20250918085707.41785-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent commit c407a13fc1 undid some changes that were made by
commits 762f295a02 and 325a269995.  Redo these changes.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/fallocate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 30c391406..afd615537 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -17,9 +17,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 #include <sys/stat.h>
 #include <sys/types.h>
@@ -396,16 +395,16 @@ int main(int argc, char **argv)
 		if (length == -2LL)
 			length = 0;
 		if (length < 0)
-			errx(EXIT_FAILURE, _("invalid length value specified"));
+			errx(EXIT_FAILURE, _("invalid length"));
 	} else {
 		/* it's safer to require the range specification (--length --offset) */
 		if (length == -2LL)
 			errx(EXIT_FAILURE, _("no length argument specified"));
 		if (length <= 0)
-			errx(EXIT_FAILURE, _("invalid length value specified"));
+			errx(EXIT_FAILURE, _("invalid length"));
 	}
 	if (offset < 0)
-		errx(EXIT_FAILURE, _("invalid offset value specified"));
+		errx(EXIT_FAILURE, _("invalid offset"));
 
 	/* O_CREAT makes sense only for the default fallocate(2) behavior
 	 * when mode is no specified and new space is allocated */
-- 
2.51.0

