Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB8270ECD
	for <util-linux@vger.kernel.org>; Wed,  9 Jul 2025 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052067; cv=none; b=uDd+3vQAdQ33icdoMiiYFT7BmDITli97EWssh/TYCWfWLOolrH6YZn170rrk0Q57gAOMFcqYAxOynvDtH3n8ZAFzAsO7oPbGzbPF6KbRloUPhxl7VuVI5HsOqkcXUrJwhgEXTiGzRR5agqoiZyux59kGm/O0mkxbquWCGqp/MaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052067; c=relaxed/simple;
	bh=TAl0cm0jDVSKCQnTPxk6ROpHz7TOlAn7PFbgmKuqfXU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BdOq9jhXIGS5+6xk0LQ4eNoswDZy0JPXi2wRupkUkv50gIzmUX2RmBxmzCyjfsv29zBpd+WK8MVzBj0q5P4Y0mqpoSpsR6+UtIedHzwSv9Cs/fladD4AlKvqtN2LZLndorJCjwRPvIApFd1Dr2J214dxX+Yjgh4jfmpHqnUi6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=KmPqTZ+x; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="KmPqTZ+x"
X-KPN-MessageId: 6ae36a91-5ca4-11f0-b9a4-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6ae36a91-5ca4-11f0-b9a4-005056abbe64;
	Wed, 09 Jul 2025 11:09:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=agr3l8Md9aEWpRDHdECzk3MoETfp/jvjHnpH87zgVh8=;
	b=KmPqTZ+xbQLTikXYWAxc19YIjXD0qobZWlmfZNbYJPnFAA+wyTD5RwX5xArbIQH3aPlr3Z/WWvz23
	 DP1ph2/P92AKkLhGU1eD0+UMHNN5++wud0qdY2DPqCQ+phTPR2p/xmVhHFiLJTxvB6zNOVsztKshPH
	 yhhlYDvmiGFm8vPs=
X-KPN-MID: 33|nZrYRh2s7zHr81cRBFB8HVt5P3w590CsN7/iWVM1wO3Z2XANv3QrVY2L2WWfM6H
 7akfBwclKpdgBLtZy5A0Muw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|xcEqh7pwV9/MvzUWy+NREss3p9TRgVr5ajZiyuEQysyNM/b9I+1ilRoAClWWcUd
 /3p9g4hu3U5L7ie3Wh43WWw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 2a43d460-5ca4-11f0-85b8-005056ab7584;
	Wed, 09 Jul 2025 11:07:40 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] column: call gettext() on an error message only when it gets printed
Date: Wed,  9 Jul 2025 11:07:32 +0200
Message-ID: <20250709090734.18263-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.2
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just mark error messages for translation, with gettext_noop(), and pass
them untranslated to the subroutines.  Then call gettext() on such a
message only when an error occurs and the message gets printed.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 text-utils/column.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index c3321ae16..96120774c 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -323,7 +323,7 @@ static char **split_or_error(const char *str, const char *errmsg)
 		if (errno == ENOMEM)
 			err_oom();
 		if (errmsg)
-			errx(EXIT_FAILURE, "%s: '%s'", errmsg, str);
+			errx(EXIT_FAILURE, "%s: '%s'", _(errmsg), str);
 		else
 			return NULL;
 	}
@@ -522,7 +522,7 @@ static void reorder_table(struct column_control *ctl)
 	struct libscols_column **wanted, *last = NULL;
 	size_t i, count = 0;
 	size_t ncols = scols_table_get_ncols(ctl->tab);
-	char **order = split_or_error(ctl->tab_order, _("failed to parse --table-order list"));
+	char **order = split_or_error(ctl->tab_order, N_("failed to parse --table-order list"));
 	char **one;
 
 	wanted = xcalloc(ncols, sizeof(struct libscols_column *));
@@ -600,23 +600,23 @@ static void modify_table(struct column_control *ctl)
 
 	if (ctl->tab_colhide)
 		apply_columnflag_from_list(ctl, ctl->tab_colhide,
-				SCOLS_FL_HIDDEN , _("failed to parse --table-hide list"));
+				SCOLS_FL_HIDDEN , N_("failed to parse --table-hide list"));
 
 	if (ctl->tab_colright)
 		apply_columnflag_from_list(ctl, ctl->tab_colright,
-				SCOLS_FL_RIGHT, _("failed to parse --table-right list"));
+				SCOLS_FL_RIGHT, N_("failed to parse --table-right list"));
 
 	if (ctl->tab_coltrunc)
 		apply_columnflag_from_list(ctl, ctl->tab_coltrunc,
-				SCOLS_FL_TRUNC , _("failed to parse --table-trunc list"));
+				SCOLS_FL_TRUNC , N_("failed to parse --table-trunc list"));
 
 	if (ctl->tab_colnoextrem)
 		apply_columnflag_from_list(ctl, ctl->tab_colnoextrem,
-				SCOLS_FL_NOEXTREMES , _("failed to parse --table-noextreme list"));
+				SCOLS_FL_NOEXTREMES , N_("failed to parse --table-noextreme list"));
 
 	if (ctl->tab_colwrap)
 		apply_columnflag_from_list(ctl, ctl->tab_colwrap,
-				SCOLS_FL_WRAP , _("failed to parse --table-wrap list"));
+				SCOLS_FL_WRAP , N_("failed to parse --table-wrap list"));
 
 	if (!ctl->tab_colnoextrem) {
 		struct libscols_column *cl = get_last_visible_column(ctl, 0);
@@ -1036,7 +1036,7 @@ int main(int argc, char **argv)
 				errx(EXIT_FAILURE, _("columns limit must be greater than zero"));
 			break;
 		case 'N':
-			ctl.tab_colnames = split_or_error(optarg, _("failed to parse column names"));
+			ctl.tab_colnames = split_or_error(optarg, N_("failed to parse column names"));
 			break;
 		case 'n':
 			ctl.tab_name = optarg;
-- 
2.48.2

