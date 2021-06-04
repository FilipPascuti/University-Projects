
namespace Assignment2
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.dgvParent = new System.Windows.Forms.DataGridView();
            this.dgvChild = new System.Windows.Forms.DataGridView();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.btnUpdateViews = new System.Windows.Forms.Button();
            this.btnUpdateDb = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgvParent)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvChild)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvParent
            // 
            this.dgvParent.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvParent.Location = new System.Drawing.Point(134, 47);
            this.dgvParent.Name = "dgvParent";
            this.dgvParent.Size = new System.Drawing.Size(851, 259);
            this.dgvParent.TabIndex = 0;
            // 
            // dgvChild
            // 
            this.dgvChild.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvChild.Location = new System.Drawing.Point(134, 350);
            this.dgvChild.Name = "dgvChild";
            this.dgvChild.Size = new System.Drawing.Size(851, 259);
            this.dgvChild.TabIndex = 1;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(140, 316);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(151, 31);
            this.label2.TabIndex = 3;
            this.label2.Text = "Child Table";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(140, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(169, 31);
            this.label1.TabIndex = 4;
            this.label1.Text = "Parent Table";
            // 
            // btnUpdateViews
            // 
            this.btnUpdateViews.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnUpdateViews.Location = new System.Drawing.Point(685, 615);
            this.btnUpdateViews.Name = "btnUpdateViews";
            this.btnUpdateViews.Size = new System.Drawing.Size(280, 85);
            this.btnUpdateViews.TabIndex = 6;
            this.btnUpdateViews.Text = "Update Views";
            this.btnUpdateViews.UseVisualStyleBackColor = true;
            this.btnUpdateViews.Click += new System.EventHandler(this.btnUpdateViews_Click);
            // 
            // btnUpdateDb
            // 
            this.btnUpdateDb.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnUpdateDb.Location = new System.Drawing.Point(221, 615);
            this.btnUpdateDb.Name = "btnUpdateDb";
            this.btnUpdateDb.Size = new System.Drawing.Size(280, 85);
            this.btnUpdateDb.TabIndex = 7;
            this.btnUpdateDb.Text = "Save Changes";
            this.btnUpdateDb.UseVisualStyleBackColor = true;
            this.btnUpdateDb.Click += new System.EventHandler(this.btnUpdateDb_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1137, 712);
            this.Controls.Add(this.btnUpdateDb);
            this.Controls.Add(this.btnUpdateViews);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.dgvChild);
            this.Controls.Add(this.dgvParent);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvParent)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvChild)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgvParent;
        private System.Windows.Forms.DataGridView dgvChild;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnUpdateViews;
        private System.Windows.Forms.Button btnUpdateDb;
    }
}

