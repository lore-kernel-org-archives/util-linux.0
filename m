Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96DB1F8AE5
	for <util-linux@vger.kernel.org>; Mon,  7 Apr 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038982; cv=none; b=T5va1FxWOJCYPssBEs81Jlvp+FiSteFvcXXxpTQ5a/m/xsqBE7jbWVTdJ6Te7OX2SmkXSJgFLKeEi7iVzwdDStj4BAvmOWqLYTcc0+J5cvb8ZbGpgcORZ8oFuFs71rYwFDlfnZCtMYRVm/jvCvC5yRzhK6F9IlkzqdsGwymU3D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038982; c=relaxed/simple;
	bh=VTxMXJGwsk5deakM/bRaTFx5tcz7Dn1bOuNinJZTbCk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6+DjCLsYadSj5HyAHsEG+J/1fWXF01a5MYJRbvQyjKhSfIi5jyFB3nV+lP1OBZFRq9741f8TFr6T2nGaq33FUd4l/0A1/QnJDj1IRSDX4FxGcGE0yClEB8Rr3Bcu0/Gl+gmg4PrlZIq70udaBCHUT/5BV5ke1DfByNBvWbXN2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Xcwv4Myj; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Xcwv4Myj"
X-KPN-MessageId: 56831140-13c3-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 56831140-13c3-11f0-86cb-005056aba152;
	Mon, 07 Apr 2025 17:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=oA/Ou2TBYbZL9SOopUbRiiSVvUMEwHblpLXSEDbLPfI=;
	b=Xcwv4MyjthcqM1gtwbcaCGa42rpdOMXkRLXvTEW5U/63Wxuey3sGSNwDvxIb5TMo3/a4QeDkbvuY7
	 O9uMRf3HXAlTJIH1DL8P4YOglRSyaahhdo2G5j/yTo5AMTJgMPvjXUZ5CqenuxXR8/gJfW0BgOuPik
	 V5rK5m+SlyYJHId8=
X-KPN-MID: 33|eazS2gHYxQg7tQwKnzwcNgNT5u0WDOgPxCnzMGi4Qjql/u3MaP4D0K8Z+/Q57un
 Y6QLhq+Y1nUIPsKPw5qi79wDYGkh5jPHW6+5rL2we1kg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|EtBZgodGQLNxzhSLm07QUyKzVdZFVj8y56XsEbNT9dB0RVMYx2kDCQUxjpaXAZC
 GUTWWyT5kJCtWXrLuUhBXiw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 418d5d49-13c3-11f0-852c-005056ab7584;
	Mon, 07 Apr 2025 17:16:18 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 8/8] column: (man) fix broken markup, and improve other markup and wordings
Date: Mon,  7 Apr 2025 17:14:39 +0200
Message-ID: <20250407151503.23394-8-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407151503.23394-1-bensberg@telfort.nl>
References: <20250407151503.23394-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit aa4efb2030 from five months ago, almost the entire text
of the section OPTIONS was underlined / in italics.  Correct that.

Also improve various other markup and wordings, and unswap the names of
--table-column and --table-columns in the first paragraph of OPTIONS.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 text-utils/column.1.adoc | 73 +++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/text-utils/column.1.adoc b/text-utils/column.1.adoc
index 9585e7fc0..97b7fec5b 100644
--- a/text-utils/column.1.adoc
+++ b/text-utils/column.1.adoc
@@ -59,15 +59,20 @@ This is the default mode (required for backwards compatibility).
 This mode is enabled with the *-x, --fillrows* option.
 
 *create a table*::
-Determine the number of columns the input contains and create a table. This mode is enabled with the *-t, --table* option. Output is aligned to the terminal width in interactive mode and 80 columns in non-interactive mode (see *--output-width* for more details). Custom formatting can be applied by using various *--table-\** options.
+Determine the number of columns the input contains and create a table.
+This mode is enabled with the *-t*/*--table* option.
+Output is aligned to the terminal width in interactive mode, and to 80 columns
+in non-interactive mode (see *--output-width* for more details).
+Custom formatting can be applied by using various **--table-*** options.
 
 Input is taken from _file_, or otherwise from standard input. Empty lines are ignored and all invalid multibyte sequences are encoded with the x<hex> convention.
 
 == OPTIONS
 
-The argument _columns_ for *--table-\** options is a comma separated list of
-user supplied names, defined with *--table-column _name1_,_name2_,...*, indices of columns, as they
-appear in the input, beginning with 1, or names, defined by a *--table-columns* attribute.
+The argument _columns_, for the **--table-*** options below, is a comma-separated list
+of user-supplied names defined with *--table-columns* _name1_**,**_name2_**,**...,
+or indices of columns as they appear in the input, beginning with 1,
+or names defined through a *--table-column* attribute.
 It's possible to mix names and indices. The special placeholder '0' (e.g. -R0) may
 be used to specify all columns and '-1' (e.g. -R -1) to specify the last visible column.
 It's possible to use ranges like '1-5' when addressing columns by indices.
@@ -76,80 +81,86 @@ It's possible to use ranges like '1-5' when addressing columns by indices.
 Use JSON output format to print the table. The option *--table-columns* is required and the option *--table-name* is recommended.
 
 *-c, --output-width* _width_::
-Output is formatted to a width specified as a number of characters. The original name of this option is *--columns*; this name is deprecated since v2.30. Note that input longer than _width_ is not truncated by default. The default is the terminal width and 80 columns in non-interactive mode. The column headers are never truncated.
+Output is formatted to a width specified as a number of characters.
+Note that input longer than _width_ is not truncated by default.
+The default is the terminal width in interactive mode, and 80 columns in non-interactive mode.
+The column headers are never truncated.
 +
-The placeholder "unlimited" (or 0) can be used to prevent restricting output width. This is recommended for example when redirecting output to a file.
+The placeholder *unlimited* (or *0*) can be used to prevent restricting the output width.
+This is recommended when redirecting output to a file.
++
+(The original long name of this option was *--columns*; this name is deprecated since v2.30.)
 
 *-d, --table-noheadings*::
-Omit printing the header. This option allows the use of user supplied column names on the command line, but keeps the header hidden when printing the table.
+Omit printing the header. This option allows having user-supplied column names on the command line, but keeps the header hidden when printing the table.
 
 *-o, --output-separator* _string_::
 Column delimiter for table output (default is two spaces).
 
 *-s, --separator* _separators_::
-Possible input item delimiters (default is whitespace).
+Possible input-item delimiters (default is whitespace).
 
 *-S, --use-spaces* _number_::
-When not in table mode, use whitespaces instead of tabulators to align the columns. This option specifies the minimum number of whitespaces that separate two columns.
+When not in table mode, use spaces instead of tabulators to align the columns. This option specifies the minimum number of spaces that separate two columns.
 
 *-t, --table*::
 Determine the number of columns the input contains and create a table. Columns are by default delimited with whitespace, or with characters supplied using the *--output-separator* option. Table output is useful for pretty-printing.
 
 *-C, --table-column* _attributes_::
-Define a column with a comma separated list of column attributes.
+Define a column with a comma-separated list of attributes.
 This option can be used more than once, every use defines a single column.
-Attributes replace some of *--table-* options. For example, *--table-column name=FOO,right*
-defines a column where text is aligned to right. The option is
-mutually exclusive to *--table-columns*.
+Attributes replace some of the **--table-*** options: for example,
+*--table-column name=FOO,right* defines a column where text is aligned to the right.
+The option is mutually exclusive with *-N*/*--table-columns*.
 +
 Supported attributes are:
 +
-*name=string*;;
+**name=**_string_;;
 Column name.
 *trunc*;;
 Truncate column text when necessary. The same as *--table-truncate*.
 *right*;;
 Right align text. The same as *--table-right*.
-*width=number*;;
-Column width. It's used only as a hint. To force it, specify the *strictwidth* attribute
+**width=**_number_;;
+Column width. It's used only as a hint. To enforce it, specify the *strictwidth* attribute
 as well.
 *strictwidth*;;
-Strictly follow column *width=* setting.
+Strictly follow the *width=* setting.
 *noextreme*;;
-Ignore unusually long cell width. See *--table-noextreme* for more details.
+Ignore unusually long content width. See *--table-noextreme* for more details.
 *wrap*;;
 Allow using a multi-line cell for long text if necessary. See *--table-wrap* for more details.
 *hide*;;
 Don't print the column. See *--table-hide* for more details.
-*json=type*;;
-Define column type for JSON output. Supported types are string, number and boolean.
+**json=**_type_;;
+Define the column type for JSON output. Supported types are *string*, *number* and *boolean*.
 
 *-N, --table-columns* _names_::
-Specify column names with a comma separated list. The names are used
-for the table header and column addressing in option arguments. See also *--table-column*.
+Specify column names with a comma-separated list. The names are used for the table header
+and for column addressing in option arguments. See also *--table-column*.
 
 *-l, --table-columns-limit* _number_::
-Specify maximum number of input columns. The last column will contain all remaining line data if the limit is smaller than the number of the columns in the input data.
+Specify the maximum number of input columns. The last column will contain all remaining line data if the limit is smaller than the number of columns in the input data.
 
 *-R, --table-right* _columns_::
-Right align text in specified columns.
+Right align text in the specified columns.
 
 *-T, --table-truncate* _columns_::
-Specify columns where text can be truncated when necessary, otherwise very long table entries may be printed on multiple lines.
+Specify the columns where text can be truncated when necessary, otherwise very long table entries may be printed on multiple lines.
 
 *-E, --table-noextreme* _columns_::
-Specify columns where is possible to ignore unusually long (longer than average) cells when calculate column width. The option has impact to the width calculation and table formatting, but the printed text is not affected.
+Specify the columns where longer-than-average content should be ignored when calculating the column width. The option influences width calculation and table formatting, but the printed text is not affected.
 +
-The option is used for the last visible column by default.
+This option is active by default for the last visible column.
 
 *-e, --table-header-repeat*::
 Print header line for each page.
 
 *-W, --table-wrap* _columns_::
-Specify columns where multi-line cells can be used for long text.
+Specify the columns where multi-line cells can be used for long text.
 
 *-H, --table-hide* _columns_::
-Don't print specified columns. The special placeholder '-' may be used to hide all unnamed columns (see *--table-columns*).
+Don't print the specified columns. The special placeholder '*-*' may be used to hide all unnamed columns (see *--table-columns*).
 
 *-O, --table-order* _columns_::
 Specify the output column order.
@@ -167,10 +178,10 @@ Preserve whitespace-only lines in the input. The default is to ignore all empty
 Specify the column to use for a tree-like output. Note that the circular dependencies and other anomalies in child and parent relation are silently ignored.
 
 *-i, --tree-id* _column_::
-Specify the column that contains each line's unique child IDs for a child-parent relation.
+Specify the column that contains each line's unique child ID for a child-parent relation.
 
 *-p, --tree-parent* _column_::
-Specify the column that contains each line's parent IDs for a child-parent relation.
+Specify the column that contains each line's parent ID for a child-parent relation.
 
 *-x, --fillrows*::
 Fill rows before filling columns.
-- 
2.48.1

